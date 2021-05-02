module "azure_backend" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-backend?ref=refactor"

  backend_config_filename = var.backend_config_filename
  location                = "centralus"

  required_tags = {
    project    = local.project
    repository = local.repository
  }
}