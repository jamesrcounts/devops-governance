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
}