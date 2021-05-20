# The principal can make any change and perform user administration over this scope
resource "azurerm_role_assignment" "owner" {
  for_each = var.owner_scope

  principal_id         = local.principal_id
  role_definition_name = "Owner"
  scope                = each.value
}

# The principal can manage all protected info for any key vault in this scope
resource "azurerm_role_assignment" "keyvault_manager" {
  for_each = var.owner_scope

  principal_id         = local.principal_id
  role_definition_name = "Key Vault Administrator"
  scope                = each.value
}

# The principal can manage all storage blobs in this scope
resource "azurerm_role_assignment" "blob_owner" {
  for_each = var.owner_scope

  principal_id         = local.principal_id
  role_definition_name = "Storage Blob Data Owner"
  scope                = each.value
}