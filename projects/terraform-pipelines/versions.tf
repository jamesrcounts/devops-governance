terraform {
  required_version = ">= 1"

  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0"
    }
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~> 2"
      configuration_aliases = [azurerm.env]
    }
  }
}