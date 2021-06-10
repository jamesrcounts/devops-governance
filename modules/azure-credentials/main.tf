locals {
  aad_script_name = var.generate_scripts ? "Add-AzureAdRoles.${var.project}.ps1" : null
  principal_id    = azuread_service_principal.sp.object_id
}

data "azurerm_subscription" "current" {}