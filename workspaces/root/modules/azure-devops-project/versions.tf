terraform {
  required_version = "~> 1.3.6"

  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0.3"
    }
  }
}