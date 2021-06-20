terraform {
  required_version = ">= 0.15.1"

  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2"
    }
  }
}

