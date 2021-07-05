terraform {
  required_version = ">= 0.15.1"

  backend "azurerm" {}

  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1"
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0"
    }
  }
}