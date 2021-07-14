locals {
  backend_config = templatefile(
    "${path.module}/templates/backend-config.tfvars.hcl",
    {
      container_name       = azurerm_storage_container.state.name
      key                  = local.blob_name
      resource_group_name  = azurerm_resource_group.state.name
      storage_account_name = azurerm_storage_account.state.name
    }
  )
}

resource "azurerm_key_vault_secret" "backend_config" {
  key_vault_id = azurerm_key_vault.config.id
  name         = "azurerm-backend-tfvars"
  value        = local.backend_config
}