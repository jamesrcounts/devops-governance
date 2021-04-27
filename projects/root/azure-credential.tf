module "azure_credentials" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-credentials?ref=azure-credentials-0.0.1"

  active_password = "primary"
  project         = local.project

  owner_scope = {
    backend = module.azure_backend.resource_group_id
  }

  update_triggers = {
    primary   = "20210424"
    secondary = "20210424"
  }
}