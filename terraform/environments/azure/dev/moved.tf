moved {
  from = azurerm_resource_group.resource_group
  to   = azurerm_resource_group.this
}

moved {
  from = azurerm_storage_account.storage
  to   = module.storage.azurerm_storage_account.this
}

moved {
  from = azurerm_storage_container.devopsn_container
  to   = module.storage.azurerm_storage_container.this["container-dev"]
}
