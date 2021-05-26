module "azure_backend" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-backend?ref=container-pipelines"

  location      = local.location
  required_tags = local.required_tags
}