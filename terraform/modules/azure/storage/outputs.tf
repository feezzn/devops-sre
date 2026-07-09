output "id" {
  description = "Storage Account resource ID."
  value       = azurerm_storage_account.this.id
}

output "name" {
  description = "Storage Account name."
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "Primary Blob service endpoint."
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "container_ids" {
  description = "Map of container names to resource IDs."
  value = {
    for name, container in azurerm_storage_container.this :
    name => container.id
  }
}
