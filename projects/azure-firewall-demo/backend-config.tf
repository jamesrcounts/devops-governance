locals {
  backend_config = templatefile(
    "${path.module}/templates/backend-config-terraformrc.hcl",
    {
      token = module.backend.token
    }
  )
}

resource "azurerm_key_vault_secret" "backend_config" {
  key_vault_id = module.azure_backend.key_vault.id
  name         = "terraformrc"
  value        = local.backend_config
}