terraform {
  required_version = "~> 1.3.6"

  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2"
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0.3"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.34"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.11"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.39"
    }
  }
}