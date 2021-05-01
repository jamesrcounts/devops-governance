locals {
  principal_id = azuread_service_principal.sp.object_id
}

data "azurerm_subscription" "current" {}