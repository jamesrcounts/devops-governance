module "azure_devops_pipelines" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-devops-pipelines?ref=aks-istio"

  backend           = module.azure_backend.backend_config
  branch_name       = "lz"
  github_pat        = var.github_pat
  project           = var.project
  repository        = var.repository
  service_principal = module.azure_credentials.service_principal

  azure_env = {
    AZURE_ENV_RG = module.azure_env.resource_group.name
    instance_id  = module.azure_env.instance_id
  }

  config_keyvault = {
    key_vault_name      = module.azure_backend.key_vault.name
    resource_group_name = module.azure_backend.resource_group.name
  }

  pipelines = {
    infrastructure = "infrastructure/azure/azure-pipelines.yml"
    networking     = "infrastructure/networking/azure-pipelines.yml"
  }
}