variable "environment" {
  description = "Deployment environment. This root module only accepts prd."
  type        = string

  validation {
    condition     = var.environment == "prd"
    error_message = "The prd root module only accepts environment = \"prd\"."
  }
}

variable "project_name" {
  description = "Short project name used in resource names."
  type        = string
  default     = "devopssre"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,12}$", var.project_name))
    error_message = "project_name must contain 3-12 lowercase letters, numbers, or hyphens."
  }
}

variable "resource_group_name" {
  description = "Existing or desired Resource Group name."
  type        = string

  validation {
    condition     = length(var.resource_group_name) >= 1 && length(var.resource_group_name) <= 90
    error_message = "resource_group_name must contain 1-90 characters."
  }
}

variable "storage_account_name" {
  description = "Existing or desired globally unique Storage Account name."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "storage_account_name must contain 3-24 lowercase letters or numbers."
  }
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "brazilsouth"
}

variable "account_replication_type" {
  description = "Storage replication strategy."
  type        = string
  default     = "GRS"
}

variable "containers" {
  description = "Private blob containers."
  type        = set(string)
  default     = ["artifacts", "logs"]
}

variable "delete_retention_days" {
  description = "Deleted blob and container retention."
  type        = number
  default     = 30
}

variable "public_network_access_enabled" {
  description = "Keep enabled until the network lab adds a Private Endpoint."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional resource tags."
  type        = map(string)
  default     = {}
}
