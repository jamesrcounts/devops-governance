resource "azurerm_container_registry" "basic" {
  location            = data.azurerm_resource_group.rg.location
  name                = replace("cr-${local.instance_id}", "-", "")
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Basic"
  tags                = data.azurerm_resource_group.rg.tags
}