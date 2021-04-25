resource "azurerm_role_assignment" "owner" {
  for_each = var.owner_scope

  principal_id         = azuread_service_principal.sp.object_id
  role_definition_name = "Owner"
  scope                = each.value
}