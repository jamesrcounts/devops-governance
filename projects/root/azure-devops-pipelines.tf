module "azure_devops_pipelines" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-devops-pipelines?ref=main"

  branch_name       = "azure-devops"
  github_pat        = var.github_pat
  project           = local.project
  repository        = local.repository
  service_principal = module.azure_credentials.service_principal
  yml_path          = "projects/root/azure-pipelines.yml"

  azuredevops = {
    pat = var.azuredevops_pat
    url = var.azuredevops_url
  }

  backend = {
    blob_name            = var.key
    container_name       = var.container_name
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
  }
}