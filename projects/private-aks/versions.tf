terraform {
  required_version = ">= 0.15.1"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0"
    }
  }
}