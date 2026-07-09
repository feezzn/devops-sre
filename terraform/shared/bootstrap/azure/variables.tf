variable "location" {
  description = "Azure region for the state resources."
  type        = string
  default     = "brazilsouth"
}

variable "unique_suffix" {
  description = "Lowercase alphanumeric suffix that makes the Storage Account name globally unique."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{4,10}$", var.unique_suffix))
    error_message = "unique_suffix must contain 4-10 lowercase letters or numbers."
  }
}

variable "tags" {
  description = "Additional tags for state resources."
  type        = map(string)
  default     = {}
}

variable "assign_current_principal_blob_data_role" {
  description = "Assign Storage Blob Data Contributor to the identity running the bootstrap."
  type        = bool
  default     = true
}
