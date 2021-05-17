module "acr" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-container-registry?ref=container-pipelines"

  resource_group_name        = module.azure_backend.resource_group.name
  log_analytics_workspace_id = module.azure_backend.log_analytics_workspace_id
}