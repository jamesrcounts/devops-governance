resource "azuread_application" "app" {
  display_name                   = "${var.project} (Managed by Terraform)"
  fallback_public_client_enabled = false
  prevent_duplicate_names        = true
  sign_in_audience               = "AzureADMyOrg"

  web {
    implicit_grant {
      access_token_issuance_enabled = false
    }
  }
}
