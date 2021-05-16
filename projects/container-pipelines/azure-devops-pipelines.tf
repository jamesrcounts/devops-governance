module "azure_devops_pipelines" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-devops-pipelines?ref=container-pipelines"

  backend           = module.azure_backend.backend_config
  branch_name       = "main"
  github_pat        = var.github_pat
  project           = local.project
  repository        = local.repository
  service_principal = module.azure_credentials.service_principal

  azure_env = {
    AZURE_ENV_RG = module.azure_env.resource_group.name
  }

  container_registry = {
    acr_name            = replace("cr-${module.azure_env.instance_id}", "-", "")
    resource_group_name = module.azure_env.resource_group.name
  }

  pipelines = {
    infrastructure = "infrastructure/azure-pipelines.yml"
    captainkube    = "captainkube/azure-build-pipeline.yml"
    nodebrady      = "nodebrady/ci-pipeline.yml"
    parrot_docker  = "parrot/azure-pipelines.docker.yaml"
    parrot_helm    = "parrot/azure-pipelines.helm.yaml"
    parrot_deploy  = "parrot/azure-pipelines.deploy.yaml"
    phippy         = "phippy/ci-pipeline.yml"
  }
}