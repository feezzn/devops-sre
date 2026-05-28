output "storage_acount_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.storage.id
}

output "sa_primary_access_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.storage.primary_access_key
  sensitive   = true
}