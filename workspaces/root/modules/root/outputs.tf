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