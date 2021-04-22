locals {
  project_id = random_pet.project_id.id
  tags       = merge(var.required_tags, var.optional_tags)
}

data "azurerm_client_config" "current" {}
resource "random_pet" "project_id" {}
