resource "azuread_application_password" "password" {
  for_each = var.update_triggers

  application_object_id = azuread_application.app.id
  display_name           = "Managed by Terraform"
  end_date_relative     = "240h"
  value                 = random_password.password_value[each.key].result
}

resource "random_password" "password_value" {
  for_each = var.update_triggers

  keepers = {
    update_trigger = each.value
  }

  length           = 16
  override_special = "_%@"
  special          = true
}