terraform {
  required_version = ">= 0.15.1"

  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "~> 0"
    }
  }
}