output "id" {
  description = "The resource group ID."
  value       = azurerm_resource_group.rg.id
}

output "name" {
  description = "The resource group name."
  value       = azurerm_resource_group.rg.name
}

output "tags" {
  description = "The resource group tags."
  value       = azurerm_resource_group.rg.tags
}