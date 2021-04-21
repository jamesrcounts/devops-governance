module "azure_backend" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-backend?ref=bootstrap"

  location = "centralus"
  required_tags = {
    repository = "jamesrcounts/devops-governance"
    project    = "terraform-root"
  }
}