module "azure_backend" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-backend?ref=aks-istio"
  providers = {
    azurerm = azurerm.bo
  }

  location      = local.location
  required_tags = local.required_tags
}