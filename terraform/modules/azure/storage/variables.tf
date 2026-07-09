variable "name" {
  description = "Globally unique Storage Account name."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.name))
    error_message = "name must contain 3-24 lowercase letters or numbers."
  }
}

variable "resource_group_name" {
  description = "Resource Group in which the Storage Account is created."
  type        = string
}

variable "location" {
  description = "Azure region in which the Storage Account is created."
  type        = string
}

variable "account_replication_type" {
  description = "Storage replication strategy."
  type        = string
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "GZRS", "RAGRS", "RAGZRS"], var.account_replication_type)
    error_message = "account_replication_type must be LRS, ZRS, GRS, GZRS, RAGRS, or RAGZRS."
  }
}

variable "containers" {
  description = "Names of private blob containers to create."
  type        = set(string)
  default     = []

  validation {
    condition = alltrue([
      for name in var.containers :
      can(regex("^[a-z0-9]([a-z0-9-]{1,61}[a-z0-9])$", name))
    ])
    error_message = "Container names must use 3-63 lowercase letters, numbers, or hyphens."
  }
}

variable "blob_versioning_enabled" {
  description = "Whether blob versioning is enabled."
  type        = bool
  default     = true
}

variable "delete_retention_days" {
  description = "Number of days deleted blobs and containers are retained."
  type        = number
  default     = 7

  validation {
    condition     = var.delete_retention_days >= 1 && var.delete_retention_days <= 365
    error_message = "delete_retention_days must be between 1 and 365."
  }
}

variable "public_network_access_enabled" {
  description = "Whether the public network endpoint is enabled. Disable after Private Endpoint is configured."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to the Storage Account."
  type        = map(string)
  default     = {}
}
