resource "azurerm_storage_container" "state" {
  container_access_type = "private"
  name                  = "state"
  storage_account_name  = azurerm_storage_account.state.name
}