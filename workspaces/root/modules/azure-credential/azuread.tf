resource "azuread_directory_role" "administrator" {
  display_name = "Global Administrator"
}

resource "azuread_application" "app" {
  display_name                   = "Terraform Root (Managed by Terraform)"
  fallback_public_client_enabled = false
  prevent_duplicate_names        = true
  sign_in_audience               = "AzureADMyOrg"

  web {
    implicit_grant {
      access_token_issuance_enabled = false
    }
  }
}

resource "azuread_application_password" "password" {
  application_object_id = azuread_application.app.id
  display_name          = "Managed by Terraform"
  end_date              = timeadd(time_static.now.rfc3339, "240h")
}

resource "azuread_service_principal" "sp" {
  app_role_assignment_required = false
  application_id               = azuread_application.app.application_id
}

resource "azuread_directory_role_assignment" "assignments" {
  role_id             = azuread_directory_role.administrator.template_id
  principal_object_id = azuread_service_principal.sp.object_id
}