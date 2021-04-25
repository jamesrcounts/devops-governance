output "service_principal" {
  sensitive = true
  value = {
    client_id     = azuread_application.app.application_id
    client_secret = azuread_application_password.password[var.active_password].value
  }
}