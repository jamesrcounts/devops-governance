resource "tfe_organization" "org" {
  name  = var.project
  email = var.admin_email
}

resource "tfe_workspace" "ws" {
  execution_mode = "local"
  name           = "default"
  organization   = tfe_organization.org.name
}

data "tfe_team" "owners" {
  name         = "owners"
  organization = tfe_organization.org.name
}

resource "tfe_team_token" "token" {
  team_id = data.tfe_team.owners.id
}