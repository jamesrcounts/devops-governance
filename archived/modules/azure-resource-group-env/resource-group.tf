resource "azurerm_resource_group" "env" {
  location = var.location
  name     = "rg-${local.instance_id}"
  tags     = local.tags
}