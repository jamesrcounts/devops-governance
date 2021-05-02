output "backend_config" {
  value = {
    blob_name            = local.blob_name
    container_name       = azurerm_storage_container.state.name
    resource_group_name  = azurerm_resource_group.state.name
    storage_account_name = azurerm_storage_account.state.name
  }
}

output "resource_group_id" {
  value = azurerm_resource_group.state.id
}