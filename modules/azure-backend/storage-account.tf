resource "azurerm_storage_account" "state" {
  account_kind              = "StorageV2"
  account_replication_type  = "RAGZRS"
  account_tier              = "Standard"
  allow_blob_public_access  = false
  enable_https_traffic_only = true
  location                  = azurerm_resource_group.state.location
  min_tls_version           = "TLS1_2"
  name                      = replace("sa-${local.project_id}", "-", "")
  resource_group_name       = azurerm_resource_group.state.name
  tags                      = local.tags

  blob_properties {
    delete_retention_policy {
      days = 30
    }
    container_delete_retention_policy {
      days = 30
    }
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "cmk_crypto_user" {
  principal_id         = azurerm_storage_account.state.identity.0.principal_id
  role_definition_name = "Key Vault Crypto User"
  scope                = azurerm_key_vault_key.generated[local.cmk_state_name].id
}

resource "azurerm_storage_account_customer_managed_key" "state" {
  depends_on = [
    azurerm_role_assignment.cmk_crypto_user
  ]

  storage_account_id = azurerm_storage_account.state.id
  key_vault_id       = azurerm_key_vault.backend.id
  key_name           = local.cmk_state_name
}
