resource "azurerm_resource_group" "env" {
  location = var.location
  name     = "rg-${local.project_id}"
  tags     = local.tags
}