module "azure_devops_pipelines" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-devops-pipelines?ref=azure-devops-pipelines-0.0.5"

  backend           = module.azure_backend.backend_config
  branch_name       = "main"
  github_pat        = var.github_pat
  project           = local.project
  repository        = local.repository
  service_principal = module.azure_credentials.service_principal

  azure_env = {
    AZURE_ENV_RG = module.azure_env.resource_group.name
  }

  pipelines = {
    agw-vm = "infrastructure/azure-pipelines.yml"
  }
}