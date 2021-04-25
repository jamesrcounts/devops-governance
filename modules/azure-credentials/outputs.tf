output "service_principal" {
  sensitive = true
  value = {
    client_id         = azuread_application.app.application_id
    client_secret     = azuread_application_password.password[var.active_password].value
    subscription_id   = data.azurerm_subscription.current.subscription_id
    subscription_name = data.azurerm_subscription.current.display_name
    tenant_id         = data.azurerm_subscription.current.tenant_id
  }
}