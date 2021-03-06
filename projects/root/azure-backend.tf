module "azure_backend" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-backend?ref=main"

  location = "centralus"

  required_tags = {
    project    = local.project
    repository = local.repository
  }
}