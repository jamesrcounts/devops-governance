output "token" {
  value     = tfe_team_token.token.token
  sensitive = true
}

output "name" {
  value = tfe_workspace.ws.name
}

output "organization" {
  value = tfe_organization.org.name
}