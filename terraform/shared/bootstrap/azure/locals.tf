locals {
  resource_group_name  = "rg-tfstate-shared-${var.location}"
  storage_account_name = "sttfstate${var.unique_suffix}"

  common_tags = merge(var.tags, {
    environment = "shared"
    managed_by  = "terraform"
    purpose     = "terraform-state"
  })
}
