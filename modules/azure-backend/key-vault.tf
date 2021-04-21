locals {
  generated_keys = ["cmk-state-${local.project_id}"]
}

resource "azurerm_key_vault" "backend" {
  enable_rbac_authorization   = true
  enabled_for_disk_encryption = true
  location                    = azurerm_resource_group.state.location
  name                        = "kv-cmk-${local.project_id}"
  purge_protection_enabled    = true
  resource_group_name         = azurerm_resource_group.state.name
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  tags                        = local.tags
  tenant_id                   = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_key_vault_key" "generated" {
  for_each = toset(local.generated_keys)

  name         = each.key
  key_vault_id = azurerm_key_vault.backend.id
  key_type     = "RSA"
  key_size     = 4096
  tags         = local.tags

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}