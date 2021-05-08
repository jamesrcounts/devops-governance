output "resource_group" {
  value = {
    id   = azurerm_resource_group.env.id
    name = azurerm_resource_group.env.name
  }
}