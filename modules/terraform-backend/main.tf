resource "tfe_organization" "org" {
  name  = var.project
  email = var.admin_email
}

resource "tfe_workspace" "ws" {
  execution_mode = "local"
  name           = "default"
  organization   = tfe_organization.org.name
}

resource "tfe_organization_token" "token" {
  organization = tfe_organization.org.name
}