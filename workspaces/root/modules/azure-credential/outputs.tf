output "service_principal" {
  description = "The module service principal configuration, formatted for easy integration into the variables module."
  value = {
    description = "Azure service principal credentials."
    variables = {
      client_id = {
        description = "The AzureAD Appication Client ID"
        value       = azuread_application.app.application_id
      }
      client_secret = {
        description = "The AzureAD Application Password"
        sensitive   = true
        value       = azuread_application_password.password.value
      }
      subscription_id = {
        description = "The Azure subscription ID"
        value       = var.subscription.subscription_id
      }
      tenant_id = {
        description = "The Azure AD tenant ID"
        value       = var.subscription.tenant_id
      }
    }
  }
}
