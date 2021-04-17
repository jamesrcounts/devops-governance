resource "azurerm_resource_group" "main" {
  name     = "rg-${local.project}"
  location = "centralus"
  tags     = local.tags
}
