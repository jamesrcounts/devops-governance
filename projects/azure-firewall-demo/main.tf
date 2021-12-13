locals {
  location = "centralus"
  project  = "azure-firewall-demo"
  required_tags = {
    project    = local.project
    repository = var.repository
  }
}