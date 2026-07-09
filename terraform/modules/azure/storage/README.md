# Azure Storage module

Módulo opinativo para Storage Accounts de uso geral.

## Exemplo

```hcl
module "storage" {
  source = "../../../modules/azure/storage"

  name                     = "stfeezzndev"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_replication_type = "LRS"
  containers               = ["artifacts", "logs"]

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

O módulo cria apenas containers privados e força HTTPS/TLS 1.2. Acesso por
Private Endpoint será adicionado após o módulo de rede.
