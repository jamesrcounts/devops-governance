module "azure_credentials" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-credentials?ref=container-pipelines"

  aad_roles       = ["Directory Readers"]
  aad_script_name = var.aad_script_name
  active_password = "primary"
  project         = var.project

  owner_scope = {
    backend = module.azure_backend.resource_group_id
    env     = module.azure_env.resource_group.id
  }

  update_triggers = {
    primary   = "20210424"
    secondary = "20210424"
  }
}