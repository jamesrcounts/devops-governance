output "client_id" {
  description = "The AzureAD Appication Client ID"
  value       = azuread_application.app.application_id
}

output "client_secret" {
  description = "The AzureAD Application Password"
  sensitive   = true
  value       = azuread_application_password.password.value
}

output "subscription_id" {
  description = "The Azure subscription ID"
  value       = var.subscription.subscription_id
}

output "subscription_name" {
  description = "The Azure subscription name."
  value       = var.subscription.display_name
}

output "tenant_id" {
  description = "The Azure AD tenant ID"
  value       = var.subscription.tenant_id
}