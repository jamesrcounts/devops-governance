provider "azurerm" {
  features {}
}

provider "tfe" {
  token = var.tfe_token
}
