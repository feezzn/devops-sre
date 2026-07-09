# Terraform: de consumidor a autor de módulos

Este laboratório evolui o código original sem apagar o histórico em `AZURE/` e
`AWS/`. A primeira implementação usa Azure e trabalha quatro decisões comuns em
plataformas corporativas:

1. contrato pequeno e previsível para o módulo;
2. state e blast radius separados por ambiente;
3. bootstrap do backend separado da infraestrutura que o consome;
4. segurança como padrão, sem expor todas as opções do provider.

## Estrutura

```text
terraform/
├── modules/
│   └── azure/
│       └── storage/
├── environments/
│   └── azure/
│       ├── dev/
│       ├── hml/
│       └── prd/
└── shared/
    └── bootstrap/
        └── azure/
```

Os três ambientes são root modules independentes. A pequena repetição é
intencional: cada diretório pode ter credenciais, aprovação, pipeline e state
próprios. O módulo compartilhado concentra a lógica do recurso, não a política
de entrega de cada ambiente.

## Reutilização do laboratório original

O ambiente `dev` foi alinhado aos recursos já existentes:

- Resource Group `rg-devops-dev`;
- Storage Account `stfeezzndev`;
- container `container-dev`.

O arquivo `environments/azure/dev/moved.tf` traduz os endereços antigos para os
endereços do módulo. Um plan de ensaio contra o state original confirmou:
`0 to add, 3 to change, 0 to destroy`. As mudanças são in-place: tags,
versionamento/retenção, bloqueio de blob público anônimo e substituição do
argumento depreciado `storage_account_name` por `storage_account_id`.

Depois de criar o backend compartilhado, migre o state sem importar ou recriar
recursos:

```bash
# Execute a partir da raiz do repositório.
cp AZURE/terraform.tfstate AZURE/terraform.tfstate.pre-module-migration.backup
cp AZURE/terraform.tfstate terraform/environments/azure/dev/terraform.tfstate

cd terraform/environments/azure/dev
cp terraform.tfvars.example terraform.tfvars
cp backend.hcl.example backend.hcl

terraform init -migrate-state -backend-config=backend.hcl

# Persiste primeiro a mudança de endereços, separada do hardening.
terraform plan -refresh-only -out=migrate.tfplan
terraform apply migrate.tfplan

# Revisa as alterações in-place do módulo.
terraform plan
```

Após a migração, `AZURE/` é apenas histórico e não deve mais executar
`plan/apply`, pois seu state local se torna uma cópia desatualizada.

## Laboratório 1 — backend e módulo de storage

### 1. Criar o backend

O backend não pode criar a si próprio. Primeiro, inicialize o bootstrap usando
state local:

```bash
az login
export ARM_SUBSCRIPTION_ID="$(az account show --query id -o tsv)"

cd terraform/shared/bootstrap/azure
cp terraform.tfvars.example terraform.tfvars
terraform init -backend=false
terraform plan -out=tfplan
terraform apply tfplan
terraform output
```

Depois de o Storage Account existir, copie
`backend.hcl.example` para `backend.hcl`, substitua os valores pelos outputs e
migre o próprio state do bootstrap:

```bash
cp backend.hcl.example backend.hcl
terraform init -migrate-state -backend-config=backend.hcl
```

`terraform.tfvars`, `backend.hcl`, plans e states são ignorados pelo Git.
O bootstrap concede `Storage Blob Data Contributor` à identidade que o executa,
pois o backend usa Microsoft Entra ID em vez de colocar uma access key no
arquivo. Essa criação de role assignment exige permissão como Owner ou User
Access Administrator. Se a autorização ainda não tiver propagado, aguarde
alguns minutos antes de repetir o `init`.

### 2. Executar o ambiente dev

```bash
cd ../../../environments/azure/dev
cp terraform.tfvars.example terraform.tfvars
cp backend.hcl.example backend.hcl

terraform init -backend-config=backend.hcl
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

Repita o fluxo em `hml` ou `prd`, usando uma chave de backend diferente. Não
use workspaces neste laboratório: diretórios e states explícitos deixam a
fronteira operacional visível.

## O contrato do módulo

Entradas representam decisões que o consumidor realmente deve tomar:

- nome, localização e Resource Group;
- replicação;
- containers;
- retenção;
- tags.

Configurações como TLS mínimo, HTTPS obrigatório e bloqueio de acesso público
anônimo são guardrails internos. Isso evita transformar o módulo em uma cópia
da documentação do provider.

Outputs expõem IDs e endpoints necessários para composição. Chaves de acesso
não são outputs: valores `sensitive` continuam armazenados no state e devem ser
evitados quando Managed Identity/RBAC resolve o acesso.

## Versionamento

Enquanto o módulo e os ambientes estão neste mesmo repositório, o `source`
local não possui uma versão independente:

```hcl
source = "../../../modules/azure/storage"
```

O próximo estágio é extrair módulos estáveis para um repositório ou registry e
consumi-los por versão imutável:

```hcl
source = "git::ssh://git@github.com/ORG/terraform-azurerm-storage.git?ref=v1.0.0"
```

Regra prática de SemVer:

- `PATCH`: correção sem alterar o contrato;
- `MINOR`: nova entrada opcional ou funcionalidade compatível;
- `MAJOR`: remoção, renomeação ou mudança incompatível.

## Próximas etapas

1. módulo Azure Network e composição entre outputs/inputs;
2. Private Endpoint para remover acesso público do Storage;
3. módulo AKS consumindo a rede;
4. módulo AWS S3 equivalente para comparar contratos;
5. testes e pipeline de `fmt`, `validate`, lint e security scan;
6. publicação e versionamento do módulo.
