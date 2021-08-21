module "aks_cluster_identity" {
  source = "../"

  resource_group = azurerm_resource_group.rgs["backend"]
  scopes = {
    aks        = azurerm_resource_group.rgs["aks"].id
    networking = azurerm_resource_group.rgs["networking"].id
  }
}

output "test" {
  value = module.aks_cluster_identity.msi_resource_id
}

resource "azurerm_resource_group" "rgs" {
  for_each = toset(["backend", "aks", "networking"])

  name     = "rg-${each.key}"
  location = "centralus"
  tags     = { instance_id = var.instance_id }
}

provider "azurerm" {
  features {}
}