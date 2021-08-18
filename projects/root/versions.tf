terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0"
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