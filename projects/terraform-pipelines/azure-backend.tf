module "azure_backend" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-backend?ref=main"

  location      = local.location
  required_tags = local.required_tags
}