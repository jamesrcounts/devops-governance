locals {
  # Manual check for null because the count may not be known.
  key_vaults = var.config_keyvault == null ? [] : ["kv"]
}

resource "azuredevops_variable_group" "kv" {
  for_each = toset(local.key_vaults)

  project_id   = azuredevops_project.project.id
  name         = "key-vault"
  description  = "Specifies the name and location of the Azure Key Vault for configuration data."
  allow_access = false

  variable {
    name  = "KEYVAULT_NAME"
    value = var.config_keyvault.key_vault_name
  }

  variable {
    name  = "KEYVAULT_RESOURCE_GROUP_NAME"
    value = var.config_keyvault.resource_group_name
  }
}
