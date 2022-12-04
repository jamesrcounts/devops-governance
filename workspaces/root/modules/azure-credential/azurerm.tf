resource "azurerm_role_assignment" "owner" {
  principal_id         = azuread_service_principal.sp.object_id
  role_definition_name = "Owner"
  scope                = var.subscription.id
}

resource "azurerm_role_assignment" "keyvault_manager" {
  principal_id         = azuread_service_principal.sp.object_id
  role_definition_name = "Key Vault Administrator"
  scope                = var.subscription.id
}

resource "azurerm_role_assignment" "blob_owner" {
  principal_id         = azuread_service_principal.sp.object_id
  role_definition_name = "Storage Blob Data Owner"
  scope                = var.subscription.id
}
