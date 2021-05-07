module "azure_devops_pipelines" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-devops-pipelines?ref=azure-devops-pipelines-0.0.3"

  backend           = module.azure_backend.backend_config
  branch_name       = "main"
  github_pat        = var.github_pat
  project           = local.project
  repository        = local.repository
  service_principal = module.azure_credentials.service_principal
  yml_path          = "azure-pipelines.yml"
}