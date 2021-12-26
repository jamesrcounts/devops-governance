terraform {
  required_version = ">= 1"

  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2"
    }
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~> 2"
      configuration_aliases = [azurerm.env]
    }
    pkcs12 = {
      source  = "chilicat/pkcs12"
      version = "~> 0"
    }
  }
}