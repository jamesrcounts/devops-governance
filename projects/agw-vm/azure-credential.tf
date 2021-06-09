module "azure_credentials" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-credentials?ref=azure-credentials-0.0.4"

  active_password = "secondary"
  project         = var.project

  owner_scope = {
    backend = module.azure_backend.resource_group.id
    env     = module.azure_env.resource_group.id
  }

  update_triggers = {
    primary   = "2021-06-08T00:00:00Z"
    secondary = "2021-06-08T00:00:00Z"
  }
}