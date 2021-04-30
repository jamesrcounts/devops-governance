terraform {
  required_version = ">= 0.15.0"

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

provider "azurerm" {
  features {
    key_vault {
      recover_soft_deleted_key_vaults = true
      purge_soft_delete_on_destroy    = true
    }

    template_deployment {
      delete_nested_items_during_deletion = true
    }

    virtual_machine {
      delete_os_disk_on_deletion = true
    }

    virtual_machine_scale_set {
      roll_instances_when_required = true
    }
  }
}
