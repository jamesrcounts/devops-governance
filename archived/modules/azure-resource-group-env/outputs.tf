output "instance_id" {
  value = local.instance_id
}

output "resource_group" {
  value = {
    id   = azurerm_resource_group.env.id
    name = azurerm_resource_group.env.name
  }
}