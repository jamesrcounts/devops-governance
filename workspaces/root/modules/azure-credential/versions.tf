terraform {
  required_version = "~> 1.3.6"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.31"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.34"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
  }
}