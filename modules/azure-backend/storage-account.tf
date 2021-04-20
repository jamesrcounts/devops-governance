resource "azurerm_storage_account" "state" {
  account_replication_type = "GRS"
  account_tier             = "Standard"
  location                 = azurerm_resource_group.state.location
  name                     = replace("sa-${local.project_id}", "-", "")
  resource_group_name      = azurerm_resource_group.state.name
  tags                     = local.tags
}