module "azure_devops_pipelines" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-devops-pipelines?ref=aks-istio"

  backend           = module.azure_backend.backend_config
  branch_name       = "main"
  github_pat        = var.github_pat
  project           = local.project
  repository        = local.repository
  service_principal = module.azure_credentials.service_principal

  azure_env = {
    AZURE_ENV_RG = module.azure_env.resource_group.name
  }

  config_keyvault = {
    key_vault_name      = module.azure_backend.key_vault.name
    resource_group_name = module.azure_backend.resource_group.name
  }

  container_registry = {
    acr_name            = module.acr.name
    resource_group_name = module.azure_backend.resource_group.name
  }

  pipelines = {
    infrastructure = "infrastructure/azure-pipelines.yml"
  }
}