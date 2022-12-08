resource "azurerm_user_assigned_identity" "aks" {
  location            = var.resource_group.location
  name                = "uai-aks-${local.instance_id}"
  resource_group_name = var.resource_group.name
  tags                = var.resource_group.tags
}

resource "azurerm_role_assignment" "networking" {
  for_each = toset(["Network Contributor", "Private DNS Zone Contributor"])

  principal_id         = azurerm_user_assigned_identity.aks.principal_id
  role_definition_name = each.key
  scope                = var.scopes["networking"]
}

resource "azurerm_role_assignment" "aks" {
  for_each = toset(["Monitoring Metrics Publisher"])

  principal_id         = azurerm_user_assigned_identity.aks.principal_id
  role_definition_name = each.key
  scope                = var.scopes["aks"]
}