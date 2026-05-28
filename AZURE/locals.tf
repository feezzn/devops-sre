locals {
  resource_group_name  = "rg-devops-${var.environment}"
  storage_account_name = "stfeezzn${var.environment}"
  container_name       = "container-${var.environment}"

  common_tags = {
    managed_by  = "Terraform"
    owner       = "Infrastructure Team"
    environment = var.environment
  }
}