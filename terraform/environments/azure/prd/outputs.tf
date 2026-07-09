output "storage_account" {
  description = "Storage module contract exposed by the prd root module."
  value = {
    id                    = module.storage.id
    name                  = module.storage.name
    primary_blob_endpoint = module.storage.primary_blob_endpoint
    container_ids         = module.storage.container_ids
  }
}
