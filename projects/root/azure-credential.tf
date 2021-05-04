module "azure_credentials" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-credentials?ref=azure-credentials-0.0.2"

  active_password = "primary"
  project         = local.project

  owner_scope = {
    subscription = data.azurerm_subscription.current.id
  }

  update_triggers = {
    primary   = "20210424"
    secondary = "20210424"
  }
}

data "azurerm_subscription" "current" {}
