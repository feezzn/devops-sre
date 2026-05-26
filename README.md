# DevOps SRE - Terraform Fundamentals Lab 🚀

Laboratório de aprendizado de **Terraform** com infraestrutura básica em **AWS** e **Azure**. Objetivo: preparação para **AWS Certified Associate** e domínio de IaC em ambiente empresarial.

---

## 📚 Objetivos de Aprendizado

- ✅ Fundamentos de Terraform (HCL, State, Modules)
- ✅ Infraestrutura **AWS**: EC2, S3, VPC, Security Groups, ECR
- ✅ Infraestrutura **Azure**: VMs, Storage Accounts, VNets, Container Registry
- ✅ Implementação de **Modules** para reutilização
- ✅ Boas práticas empresariais (variáveis, outputs, tfvars)
- ✅ CI/CD com GitHub Actions (Fase 2)
- ✅ Cost optimization & cleanup

---

## 🏗️ Estrutura do Projeto

```
devops-sre/
├── README.md                    # Este arquivo
├── state.tf                     # Backend S3 (remote state)
├── terraform.tf                 # Provider & Terraform version
├── variables.tf                 # Declaração de variáveis
├── outputs.tf                   # Outputs da infra
├── main.tf                      # Recursos principais (será refatorado em modules)
│
├── modules/                     # Módulos reutilizáveis (Fase 2)
│   ├── aws/
│   │   ├── ec2/
│   │   ├── s3/
│   │   ├── vpc/
│   │   └── ecr/
│   └── azure/
│       ├── vm/
│       ├── storage/
│       ├── vnet/
│       └── acr/
│
├── environments/                # Configurações por ambiente (Fase 2)
│   ├── dev.tfvars
│   ├── staging.tfvars
│   └── prod.tfvars
│
└── docs/                        # Documentação técnica
    ├── ARCHITECTURE.md
    ├── COST_ESTIMATION.md
    └── TROUBLESHOOTING.md
```

---

## 🚀 Início Rápido

### Pré-requisitos

```bash
# AWS CLI & Credentials
aws configure --profile svc_cli
aws sts get-caller-identity

# Azure CLI & Login
az login
az account show

# Terraform CLI
terraform version  # 1.5+
```

### Inicializar Terraform

```bash
# Clonar/acessar diretório
cd devops-sre

# Inicializar com backend S3 remoto
terraform init

# Listar workspaces (útil para múltiplos ambientes)
terraform workspace list
```

### Workflow Básico

```bash
# 1. Planejar mudanças
terraform plan -out=tfplan

# 2. Revisar plano
cat tfplan  # ou terraform show tfplan

# 3. Aplicar infraestrutura
terraform apply tfplan

# 4. Verificar outputs
terraform output

# 5. Destruir (cleanup - IMPORTANTE para não gastar $$$)
terraform destroy
```

---

## 📦 Recursos que Vamos Criar

### **Fase 1: Recursos Básicos** (ATUAL)

#### AWS
- **VPC** com subnets públicas e privadas
- **EC2** t3.micro (free tier eligible)
- **S3** com versionamento
- **Security Group** para acesso SSH/HTTP
- **ECR** para container images

#### Azure
- **Resource Group** por ambiente
- **Virtual Network** com subnets
- **Virtual Machine** (B1s - muito barato)
- **Storage Account** (blob storage)
- **Container Registry** (ACR)

**Custo estimado**: ~$15-20/mês (ambas clouds com free tier)

### **Fase 2: Modules & Best Practices**
- Refatorar recursos em módulos reutilizáveis
- Separar por ambiente (dev, staging, prod)
- Implementar variables e outputs
- Adicionar tagging strategy

### **Fase 3: CI/CD**
- GitHub Actions para `plan` em PR
- Auto-apply em merge para `main`
- Integração com Terraform Cloud/Enterprise

---

## 🔧 Configuração de Variáveis

### Criar arquivo `terraform.tfvars`

```hcl
# AWS
aws_region       = "us-east-1"
environment      = "dev"
project_name     = "devops-sre"

# Azure
azure_region     = "eastus"
azure_environment = "dev"
```

### Rodar com variáveis

```bash
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

---

## 💾 State Management

Estado é armazenado remotamente em **S3** (definido em `state.tf`):

```bash
# Visualizar estado remoto
terraform state list
terraform state show aws_instance.main

# Fazer backup local (segurança)
terraform state pull > terraform.tfstate.backup
```

⚠️ **Nunca commitar `terraform.tfstate` no Git!**

---

## 📊 Roadmap de Aprendizado

| Semana | Foco | Entregável |
|--------|------|-----------|
| 1 | Bases de Terraform + Backend | `state.tf` + `terraform.tf` |
| 2 | Primeiro recurso (EC2/VM) | EC2 + Security Group rodando |
| 3 | Storage + Networking | S3/Storage + VPC criados |
| 4 | Módulos (refatoração) | Estrutura de módulos pronta |
| 5 | Múltiplos ambientes | dev.tfvars, staging.tfvars |
| 6 | GitHub Actions | CI/CD básico funcionando |
| 7 | Cost optimization | Tagging, destroys automáticos |

---

## 🎯 Boas Práticas Implementadas

✅ **Backend Remoto**: State centralizado em S3  
✅ **Versionamento**: Histórico completo de mudanças  
✅ **Módulos**: Código reutilizável e organizado  
✅ **Variables**: Configurações separadas de código  
✅ **Outputs**: Valores importantes expostos  
✅ **Tagging**: Rastreabilidade de recursos  
✅ **Workspace Strategy**: Separação dev/staging/prod  

---

## 📖 Referências Úteis

- [Terraform Docs](https://www.terraform.io/docs)
- [AWS Terraform Provider](https://registry.terraform.io/providers/hashicorp/aws/latest)
- [Azure Terraform Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
- [AWS Certified Associate](https://aws.amazon.com/certification/certified-associate-solutions-architect/)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/recommended-practices)

---

## ⚠️ Avisos Importantes

1. **Custos**: AWS Free Tier cobre os recursos básicos. Azure Free Trial = 200 USD. Monitorar CloudWatch/Billing!
2. **Segurança**: Nunca commitar credentials, use IAM roles
3. **Destroy**: Sempre fazer `terraform destroy` após testes para não gastar
4. **State Lock**: Evitar correr `terraform apply` simultaneamente

---

## 🤝 Contribuindo

Este é um lab pessoal de aprendizado. Sinta-se livre para:
- Experimentar novos recursos
- Adicionar novos módulos
- Documentar learnings
- Refatorar conforme aprende

---

**Status**: 🚀 Em desenvolvimento  
**Última atualização**: 26 de maio de 2026  
**Objetivo**: AWS Certified Associate + Terraform Master