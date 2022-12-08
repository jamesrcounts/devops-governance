module "azure_credentials" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-credentials?ref=azure-credentials-0.0.5"

  active_password = "primary"
  key_vault       = module.azure_backend.key_vault
  project         = local.project

  // aad_roles = [
  //   "Application Administrator",
  //   "Directory Readers",
  //   "Groups Administrator"
  // ]

  owner_scope = {
    backend = module.azure_backend.resource_group.id
    // env     = module.azure_env.resource_group.id
    // hub     = module.azure_hub.resource_group.id
  }

  update_triggers = {
    primary   = time_rotating.primary.rfc3339
    secondary = time_rotating.secondary.rfc3339
  }
}

resource "time_rotating" "primary" {
  rotation_hours = 120
}

resource "time_rotating" "secondary" {
  rotation_hours = 180
}
