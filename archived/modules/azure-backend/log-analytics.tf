resource "azurerm_log_analytics_workspace" "diagnostics" {
  name                = "la-${local.project_id}"
  location            = azurerm_resource_group.state.location
  resource_group_name = azurerm_resource_group.state.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.tags
}