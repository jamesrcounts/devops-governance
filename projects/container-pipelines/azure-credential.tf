module "azure_credentials" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-credentials?ref=azure-credentials-0.0.4"

  aad_roles       = ["Directory Readers", "Groups Administrator"]
  aad_script_name = var.aad_script_name
  active_password = "primary"
  project         = var.project

  owner_scope = {
    backend = module.azure_backend.resource_group.id
    env     = module.azure_env.resource_group.id
  }

  update_triggers = {
    primary   = "2021-05-30T00:00:00Z"
    secondary = "2021-06-05T00:00:00Z"
  }
}