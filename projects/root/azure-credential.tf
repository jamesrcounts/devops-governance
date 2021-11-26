module "azure_credentials" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-credentials?ref=azure-credentials-0.0.5"

  active_password  = "secondary"
  generate_scripts = var.generate_scripts
  key_vault        = module.azure_backend.key_vault
  project          = local.project

  aad_roles = [
    "Application Administrator",
    "Directory Readers",
    "Groups Administrator"
  ]

  owner_scope = {
    ops = data.azurerm_subscription.current.id
    app = data.azurerm_subscription.apps.id
  }

  update_triggers = {
    primary   = time_rotating.primary.rfc3339
    secondary = time_rotating.secondary.rfc3339
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_subscription" "apps" {
  subscription_id = "77fc5cff-a120-47a1-83bc-5c64163f872d"
}

resource "time_rotating" "primary" {
  rotation_hours = 120
}

resource "time_rotating" "secondary" {
  rotation_hours = 120
}
