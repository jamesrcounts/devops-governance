terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0"
    }
    azurerm = {
      configuration_aliases = [azurerm.bo, azurerm.env]
      source                = "hashicorp/azurerm"
      version               = "~> 2"
    }
  }
}