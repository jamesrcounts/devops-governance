terraform {
  required_version = "~> 1.3.6"

  required_providers {
    # azuread = {
    #   source  = "hashicorp/azuread"
    #   version = "~> 2.31"
    # }
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
    # time = {
    #   source  = "hashicorp/time"
    #   version = "~> 0.9"
    # }
  }
}