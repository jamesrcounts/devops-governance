module "azure_env" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-resource-group-env?ref=azure-resource-group-env-0.0.3"

  providers = {
    azurerm = azurerm.apps
  }

  location      = local.location
  required_tags = local.required_tags
}