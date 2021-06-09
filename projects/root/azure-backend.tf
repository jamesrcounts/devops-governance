module "azure_backend" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-backend?ref=azure-backend-0.0.5"

  backend_config_filename = var.backend_config_filename
  location                = "centralus"

  required_tags = {
    project    = local.project
    repository = local.repository
  }
}