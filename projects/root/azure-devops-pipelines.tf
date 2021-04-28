module "azure_devops_pipelines" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-devops-pipelines?ref=azure-devops"

  branch_name       = "azure-devops"
  project           = local.project
  repository        = local.repository
  service_principal = module.azure_credentials.service_principal
  yml_path          = "projects/root/azure-pipelines.yml"

  backend = {
    blob_name            = var.container_name
    container_name       = var.key
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
  }
}