variable "environment" {
  description = "The environment for the resources (e.g., dev, uat, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "uat", "prod"], var.environment)
    error_message = "Environment must be one of 'dev', 'uat', or 'prod'."
  }
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "Brazilsouth"
}

variable "account_tier" {
  description = "The performance tier of the storage account (e.g., Standard, Premium)"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Account tier must be either 'Standard' or 'Premium'."
  }
}

variable "account_replication_type" {
  description = "The replication strategy for the storage account (e.g., LRS, GRS, RA-GRS)"
  type        = string
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "GRS", "RA-GRS"], var.account_replication_type)
    error_message = "Replication type must be one of 'LRS', 'GRS', or 'RA-GRS'."
  }
}
