module "azure_devops_pipelines" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-devops-pipelines?ref=azure-devops-pipelines-0.0.8"

  backend           = module.azure_backend.backend_config
  branch_name       = "main"
  github_pat        = var.github_pat
  project           = local.project
  repository        = local.repository
  service_principal = module.azure_credentials.service_principal

  azure_env = {
    AZURE_ENV_INSTANCE_ID     = module.azure_env.instance_id
    AZURE_ENV_SUBSCRIPTION_ID = data.azurerm_client_config.env.subscription_id
    AZURE_OPS_INSTANCE_ID     = module.azure_backend.resource_group.tags["instance_id"]
    AZURE_OPS_SUBSCRIPTION_ID = data.azurerm_client_config.ops.subscription_id
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
    base               = "infrastructure/azure-pipelines.yml"
    captainkube-chart  = "captainkube/azure-pipelines.helm.yml"
    captainkube-deploy = "captainkube/azure-pipelines.deploy.yml"
    captainkube-docker = "captainkube/azure-pipelines.docker.yml"
    kubernetes-dev     = "infrastructure/azure-pipelines.kubernetes-dev.yml"
    kubernetes-prd     = "infrastructure/azure-pipelines.kubernetes-prd.yml"
    nodebrady-chart    = "nodebrady/azure-pipelines.helm.yml"
    nodebrady-deploy   = "nodebrady/azure-pipelines.deploy.yml"
    nodebrady-docker   = "nodebrady/azure-pipelines.docker.yml"
    parrot-deploy      = "parrot/azure-pipelines.deploy.yaml"
    parrot-docker      = "parrot/azure-pipelines.docker.yaml"
    parrot-chart       = "parrot/azure-pipelines.helm.yaml"
    phippy-chart       = "phippy/azure-pipelines.helm.yml"
    phippy-deploy      = "phippy/azure-pipelines.deploy.yml"
    phippy-docker      = "phippy/azure-pipelines.docker.yml"
  }
}

