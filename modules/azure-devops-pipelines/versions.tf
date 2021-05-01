terraform {
  required_version = ">= 0.15"

  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0.1"
    }
  }
}

provider "azuredevops" {
  org_service_url       = var.azuredevops.url
  personal_access_token = var.azuredevops.pat
}