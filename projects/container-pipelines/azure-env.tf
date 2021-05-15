module "azure_env" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-resource-group-env?ref=container-pipelines"

  location      = local.location
  required_tags = local.required_tags
}