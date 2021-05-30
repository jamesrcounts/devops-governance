module "azure_backend" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-backend?ref=azure-backend-0.0.5"

  location      = local.location
  required_tags = local.required_tags
}