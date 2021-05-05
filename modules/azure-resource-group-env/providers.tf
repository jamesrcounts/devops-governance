terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.57"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}
