provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

provider "azuread" {
  client_id     = var.client_id
  client_secret = var.client_secret
  tenant_id     = var.tenant_id
}

provider "azuredevops" {
  org_service_url       = var.azuredevops_url
  personal_access_token = var.azuredevops_pat
}

provider "azurerm" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "github" {
  owner = "olive-mercury"
  token = var.github_pat
}

provider "tfe" {
  token = var.tfe_token
}
