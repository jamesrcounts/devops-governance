provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

provider "azuredevops" {}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias           = "env"
  subscription_id = var.arm_env_subscription_id

  features {}
}