output "msi_resource_id" {
  description = "The user assigned identity ID."
  value       = azurerm_user_assigned_identity.aks.id
}