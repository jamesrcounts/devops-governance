terraform {
  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2"
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2"
    }
  }
}