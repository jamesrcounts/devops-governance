module "azure_credentials" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-credentials?ref=terraform-pipelines"

  application_administrator_script_name = var.application_administrator_script_name
  active_password                       = "primary"
  project                               = local.project

  owner_scope = {
    subscription = data.azurerm_subscription.current.id
  }

  update_triggers = {
    primary   = "20210424"
    secondary = "20210424"
  }
}

data "azurerm_subscription" "current" {}
