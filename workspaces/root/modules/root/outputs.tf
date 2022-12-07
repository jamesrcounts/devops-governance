output "oauth_token_id" {
  description = "The ID of the OAuth token associated with the OAuth client."
  value       = tfe_oauth_client.github.oauth_token_id
}

output "tfc_organization" {
  description = "The Terraform Cloud Organization Details"
  value = {
    name = tfe_organization.org.name
  }
}

output "variable_set" {
  description = "Root variable sets that can be reused by child workspaces."
  value       = { for k, v in module.variable : k => v.id if contains(["aws"], k) }
}