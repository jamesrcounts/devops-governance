resource "azuread_application_password" "password" {
  for_each = var.update_triggers

  application_object_id = azuread_application.app.id
  display_name          = "Managed by Terraform"
  end_date              = timeadd(each.value, "240h")
}

