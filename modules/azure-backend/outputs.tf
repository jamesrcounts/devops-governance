output "backend_config" {
  value = {
    container_name       = azurerm_storage_container.state.name
    resource_group_name  = azurerm_resource_group.state.name
    storage_account_name = azurerm_storage_account.state.name
  }
}