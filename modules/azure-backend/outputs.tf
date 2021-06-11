output "backend_config" {
  value = {
    blob_name            = local.blob_name
    container_name       = azurerm_storage_container.state.name
    resource_group_name  = azurerm_resource_group.state.name
    storage_account_name = azurerm_storage_account.state.name
  }
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.diagnostics.id
}

output "resource_group" {
  value = {
    id   = azurerm_resource_group.state.id
    name = azurerm_resource_group.state.name
    tags = azurerm_resource_group.state.tags
  }
}

output "key_vault" {
  value = {
    name = azurerm_key_vault.config.name
  }
}