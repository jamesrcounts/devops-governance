module "azure_credentials" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-credentials?ref=azure-credentials-0.0.4"

  active_password = "primary"
  project         = var.project

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
  rfc3339        = time_static.now.rfc3339
  rotation_hours = 120
}

resource "time_rotating" "secondary" {
  rfc3339        = timeadd(time_static.now.rfc3339, "120h")
  rotation_hours = 120
}

resource "time_static" "now" {}
