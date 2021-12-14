locals {
  credentials = templatefile(
    "${path.module}/templates/terraformrc.hcl",
    {
      token = module.backend.token
    }
  )

  backend_config = templatefile(
    "${path.module}/templates/backend-config.hcl",
    {
      workspace    = module.backend.name
      organization = module.backend.organization
    }
  )
}

resource "azurerm_key_vault_secret" "credentials" {
  for_each = {
    terraformrc    = local.credentials
    backend-config = local.backend_config
  }

  key_vault_id = module.azure_backend.key_vault.id
  name         = each.key
  value        = each.value
}