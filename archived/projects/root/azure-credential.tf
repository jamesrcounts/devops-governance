module "azure_credentials" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-credentials?ref=azure-credentials-0.0.5"

  active_password = "secondary"
  key_vault       = module.azure_backend.key_vault
  project         = local.project

  aad_roles = [
    "Application Administrator",
    "Directory Readers",
    "Groups Administrator"
  ]

  owner_scope = {
    ops = data.azurerm_subscription.current.id
    env = data.azurerm_subscription.env.id
  }

  update_triggers = {
    primary   = time_rotating.primary.rfc3339
    secondary = time_rotating.secondary.rfc3339
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_subscription" "env" {
  subscription_id = var.arm_env_subscription_id
}

resource "time_rotating" "primary" {
  rotation_hours = 120
}

resource "time_rotating" "secondary" {
  rotation_hours = 120
}
