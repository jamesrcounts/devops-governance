module "azure_devops_pipelines" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-devops-pipelines?ref=refactor"

  branch_name       = "refactor"
  github_pat        = var.github_pat
  project           = local.project
  repository        = local.repository
  service_principal = module.azure_credentials.service_principal
  yml_path          = "projects/azure-pipelines.yml"

  azuredevops = {
    pat = var.azuredevops_pat
    url = var.azuredevops_url
  }

  backend = {
    blob_name            = "terraform-root.tfstate"
    container_name       = module.azure_backend.backend_config.container_name
    resource_group_name  = module.azure_backend.backend_config.resource_group_name
    storage_account_name = module.azure_backend.backend_config.storage_account_name
  }
}