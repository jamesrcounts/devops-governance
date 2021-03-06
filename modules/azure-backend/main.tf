locals {
  blob_name  = "${var.required_tags.project}.tfstate"
  project_id = random_pet.project_id.id
  tags       = merge(var.required_tags, var.optional_tags, { instance_id = local.project_id })
}

data "azurerm_client_config" "current" {}
resource "random_pet" "project_id" {}
