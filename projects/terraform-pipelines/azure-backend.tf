module "azure_backend" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-backend?ref=azure-backend-0.0.4"

  location = "centralus"

  required_tags = {
    project    = var.project
    repository = var.repository
  }
}