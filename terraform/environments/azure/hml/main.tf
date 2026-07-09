provider "azurerm" {
  features {}
}

locals {
  common_tags = merge(var.tags, {
    environment = var.environment
    managed_by  = "terraform"
    project     = var.project_name
  })
}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

module "storage" {
  source = "../../../modules/azure/storage"

  name                          = var.storage_account_name
  resource_group_name           = azurerm_resource_group.this.name
  location                      = azurerm_resource_group.this.location
  account_replication_type      = var.account_replication_type
  containers                    = var.containers
  delete_retention_days         = var.delete_retention_days
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = local.common_tags
}
