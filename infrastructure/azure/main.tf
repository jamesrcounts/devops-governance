locals {
  project = "tfaz"

  tags = {
    project = local.project
  }
}

resource "random_pet" "fido" {}
