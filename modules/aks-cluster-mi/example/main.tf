module "test" {
  source = "../"

  resource_group = data.azurerm_resource_group.net
  scope          = data.azurerm_resource_group.net.id
}

output "test" {
  value = module.test.msi_resource_id
}

data "azurerm_resource_group" "net" {
  name = "rg-${var.instance_id}"
}

provider "azurerm" {
  features {}
}