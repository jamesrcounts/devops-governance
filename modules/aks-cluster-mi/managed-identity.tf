resource "azurerm_user_assigned_identity" "aks" {
  location            = var.resource_group.location
  name                = "uai-aks-${local.instance_id}"
  resource_group_name = var.resource_group.name
  tags                = var.resource_group.tags
}

resource "azurerm_role_assignment" "aks_vnet_contributor" {
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
  role_definition_name = "Network Contributor"
  scope                = var.scope
}

resource "azurerm_role_assignment" "aks_dns_zone_contributor" {
  scope                = var.scope
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}


resource "azurerm_role_assignment" "aks_metrics_publisher" {
  scope                = var.resource_group.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}