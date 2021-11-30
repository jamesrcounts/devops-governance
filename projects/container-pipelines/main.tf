locals {
  location   = "centralus"
  project    = var.project
  repository = var.repository

  required_tags = {
    project    = local.project
    repository = local.repository
  }
}

data "azurerm_client_config" "env" {
  provider = azurerm.env
}

data "azurerm_subscription" "env" {
  subscription_id = data.azurerm_client_config.env.subscription_id
}

data "azurerm_client_config" "ops" {
}