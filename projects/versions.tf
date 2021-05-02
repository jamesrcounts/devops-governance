terraform {
  required_version = ">= 0.15.1"

  backend "azurerm" {}

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.4"
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.56"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}