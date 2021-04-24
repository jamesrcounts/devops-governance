resource "azuread_application" "application" {
  available_to_other_tenants = false
  display_name               = "${var.project} (Managed by Terraform)"
  oauth2_allow_implicit_flow = false
  prevent_duplicate_names    = true
  public_client              = false
}
