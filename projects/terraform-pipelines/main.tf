locals {
  location = "centralus"

  required_tags = {
    project    = var.project
    repository = var.repository
  }
}