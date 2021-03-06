module "azure_devops_pipelines" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-devops-pipelines?ref=azure-devops-pipelines-0.0.7"

  backend           = module.azure_backend.backend_config
  branch_name       = "main"
  github_pat        = var.github_pat
  project           = local.project
  repository        = local.repository
  service_principal = module.azure_credentials.service_principal
  terraform_version = "1.0.11"

  azure_env = {
    AZURE_ENV_SUBSCRIPTION_ID = var.arm_env_subscription_id
  }

  pipelines = {
    terraform-root = "projects/azure-pipelines.yml"
  }

  azuredevops = {
    pat = var.azuredevops_pat
    url = var.azuredevops_url
  }
}