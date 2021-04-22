module "azure_backend" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-backend?ref=azure-backend-0.0.1"

  location = "centralus"
  required_tags = {
    project    = local.project
    repository = "jamesrcounts/devops-governance"
  }
}