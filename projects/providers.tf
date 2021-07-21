provider "acme" {
  alias      = "stg"
  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

provider "azuredevops" {}

# Backend (default)
provider "azurerm" {
  subscription_id = "17fe8838-4661-4395-bdab-4136639668d9"

  features {}
}

# Environment
provider "azurerm" {
  alias           = "env"
  subscription_id = "77fc5cff-a120-47a1-83bc-5c64163f872d"

  features {}
}