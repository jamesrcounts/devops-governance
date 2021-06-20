output "backend_config" {
  value = {
    blob_name            = local.blob_name
    container_name       = azurerm_storage_container.state.name
    resource_group_name  = azurerm_resource_group.state.name
    storage_account_name = azurerm_storage_account.state.name
  }
}

output "log_analytics_workspace" {
  value = {
    id = azurerm_log_analytics_workspace.diagnostics.id
    name = azurerm_log_analytics_workspace.diagnostics.name
  }
}

output "resource_group" {
  value = {
    id   = azurerm_resource_group.state.id
    location   = azurerm_resource_group.state.location
    name = azurerm_resource_group.state.name
    tags = azurerm_resource_group.state.tags
  }
}

output "key_vault" {
  value = {
    id = azurerm_key_vault.config.id
    name = azurerm_key_vault.config.name
  }
}