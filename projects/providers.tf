provider "azuredevops" {
  org_service_url       = var.azuredevops_url
  personal_access_token = var.azuredevops_pat
}

provider "azurerm" {
  features {}
}
