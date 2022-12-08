locals {
  location   = "centralus"
  project    = var.project
  repository = var.repository

  required_tags = {
    project    = local.project
    repository = local.repository
  }
}