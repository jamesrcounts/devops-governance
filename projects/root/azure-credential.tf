module "azure_credentials" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-credentials?ref=aks-istio"

  aad_roles        = ["Application Administrator"]
  active_password  = "secondary"
  generate_scripts = var.generate_scripts
  key_vault        = module.azure_backend.key_vault
  project          = local.project

  owner_scope = {
    subscription = data.azurerm_subscription.current.id
  }

  update_triggers = {
    primary   = time_rotating.primary.rfc3339
    secondary = time_rotating.secondary.rfc3339
  }
}

data "azurerm_subscription" "current" {}

resource "time_rotating" "primary" {
  rotation_hours = 120
}

resource "time_rotating" "secondary" {
  rotation_hours = 120
}
