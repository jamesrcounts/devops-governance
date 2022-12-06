resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.namespace}"
  location = "centralus"

  tags = {
    instance_id = var.namespace
    repository  = "${var.repository.name}/${var.repository.workspace_directory}"
  }
}
