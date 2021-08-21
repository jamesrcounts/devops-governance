resource "azurerm_key_vault_secret" "exports" {
  for_each = {
    admin-group-object-id = azuread_group.aks_administrators.object_id
    msi-resource-id       = module.aks_cluster_identity.msi_resource_id
  }

  key_vault_id = module.azure_backend.key_vault.id
  name         = each.key
  value        = each.value
}