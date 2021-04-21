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
