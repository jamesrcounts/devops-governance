module "azure_credentials" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-credentials?ref=azure-credentials-0.0.4"

  aad_roles       = ["Application Administrator"]
  aad_script_name = var.aad_script_name
  active_password = "secondary"
  project         = local.project

  owner_scope = {
    subscription = data.azurerm_subscription.current.id
  }

  update_triggers = {
    primary   = "2021-05-26T00:00:00Z"
    secondary = "2021-06-08T00:00:00Z"
  }
}

data "azurerm_subscription" "current" {}
