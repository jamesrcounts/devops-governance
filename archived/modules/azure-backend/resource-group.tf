resource "azurerm_resource_group" "state" {
  location = var.location
  name     = "rg-backend-${local.project_id}"
  tags     = local.tags
}