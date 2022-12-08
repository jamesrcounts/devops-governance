resource "azuread_service_principal" "sp" {
  app_role_assignment_required = false
  application_id               = azuread_application.app.application_id
  tags                         = [var.project]
}