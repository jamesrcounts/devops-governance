module "azure_backend" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-backend?ref=aks-istio"

  location = "centralus"

  required_tags = {
    project    = local.project
    repository = local.repository
  }
}