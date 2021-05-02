module "azure_devops_pipelines" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-devops-pipelines?ref=main"

  branch_name       = "refactor"
  github_pat        = var.github_pat
  project           = local.project
  repository        = local.repository
  service_principal = module.azure_credentials.service_principal
  yml_path          = "projects/azure-pipelines.yml"
  backend           = module.azure_backend.backend_config

  azuredevops = {
    pat = var.azuredevops_pat
    url = var.azuredevops_url
  }
}