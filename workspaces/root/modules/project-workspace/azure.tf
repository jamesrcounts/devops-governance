resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.namespace}"
  location = "centralus"

  tags = {
    instance_id = local.namespace
    repository  = "${github_repository.repository.full_name}/${local.repository_working_directory}"
    workspace   = local.name
  }
}

module "rg_credentials" {
  source = "../azure-credential"

  roles        = var.roles
  scope        = azurerm_resource_group.rg.id
  subscription = var.subscription
  workspace    = local.name
}