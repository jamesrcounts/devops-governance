module "azure_devops_pipelines" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-devops-pipelines?ref=container-pipelines"

  backend           = module.azure_backend.backend_config
  branch_name       = "azureaiconf.6.21"
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
    base                 = "infrastructure/azure-pipelines.yml"
    kubernetes-dev       = "infrastructure/azure-pipelines.kubernetes-dev.yml"
    kubernetes-prd       = "infrastructure/azure-pipelines.kubernetes-prd.yml"
    "captainkube-deploy" = "captainkube/azure-pipelines.deploy.yml"
    "captainkube-docker" = "captainkube/azure-pipelines.docker.yml"
    "captainkube-chart"  = "captainkube/azure-pipelines.helm.yml"
    nodebrady            = "nodebrady/ci-pipeline.yml"
    parrot_docker        = "parrot/azure-pipelines.docker.yaml"
    "parrot-docker"      = "parrot/azure-pipelines.docker.yaml"
    parrot_helm          = "parrot/azure-pipelines.helm.yaml"
    "parrot-helm"        = "parrot/azure-pipelines.helm.yaml"
    parrot_deploy        = "parrot/azure-pipelines.deploy.yaml"
    "parrot-deploy"      = "parrot/azure-pipelines.deploy.yaml"
    phippy               = "phippy/ci-pipeline.yml"
  }
}