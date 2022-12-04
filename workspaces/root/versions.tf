terraform {
  required_version = "~> 1.3.6"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.39"
    }
  }

  cloud {
    organization = "olive-mercury"
    workspaces {
      name = "root"
    }
  }
}