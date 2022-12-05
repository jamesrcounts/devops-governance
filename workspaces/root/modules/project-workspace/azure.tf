resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.namespace}"
  location = "centralus"

  tags = {
    instance_id = local.namespace
    repository  = " var.repository.full_name/${var.workspace_directory}"
  }
}

module "rg_credentials" {
  source = "../azure-credential"

  roles        = var.roles
  scope        = azurerm_resource_group.rg.id
  subscription = var.subscription
  workspace    = local.namespace
}