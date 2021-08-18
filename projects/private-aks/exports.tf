resource "azurerm_key_vault_secret" "exports" {
  for_each = {
    msi-resource-id = module.aks_cluster_identity.msi_resource_id
  }

  key_vault_id = module.azure_backend.key_vault.id
  name         = each.key
  value        = each.value
}