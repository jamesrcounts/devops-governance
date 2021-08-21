module "azure_credentials" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-credentials?ref=main"

  aad_roles        = ["Directory Readers", "Groups Administrator"]
  active_password  = "secondary"
  generate_scripts = var.generate_scripts
  project          = var.project
  key_vault        = module.azure_backend.key_vault

  owner_scope = {
    backend = module.azure_backend.resource_group.id
    env     = module.azure_env.resource_group.id
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
  rfc3339        = timeadd(time_static.now.rfc3339, "120h")
  rotation_hours = 120
}

resource "time_static" "now" {}
