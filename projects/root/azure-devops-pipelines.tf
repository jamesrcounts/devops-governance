module "azure_devops_pipelines" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-devops-pipelines?ref=azure-devops"

  project           = local.project
  service_principal = module.azure_credentials.service_principal
}