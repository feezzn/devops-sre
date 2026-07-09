output "backend_resource_group_name" {
  description = "Resource Group used by the azurerm backend."
  value       = azurerm_resource_group.state.name
}

output "backend_storage_account_name" {
  description = "Storage Account used by the azurerm backend."
  value       = azurerm_storage_account.state.name
}

output "backend_container_name" {
  description = "Container used by the azurerm backend."
  value       = azurerm_storage_container.state.name
}

output "backend_identity_object_id" {
  description = "Object ID granted access to the backend with Azure RBAC."
  value       = data.azurerm_client_config.current.object_id
}
