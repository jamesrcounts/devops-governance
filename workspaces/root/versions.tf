terraform {
  required_version = "~> 1.3.6"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.31"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.39"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
  }

  cloud {
    organization = "olive-mercury"
    workspaces {
      name = "root"
    }
  }
}