resource "local_file" "azurerm_backend_tfvars" {
  filename = "azurerm.backend.tfvars"
  content  = data.template_file.backend_config.rendered
}

data "template_file" "backend_config" {
  template = file("${path.module}/templates/backend-config.tfvars.hcl")
  vars = {
    container_name       = "state"
    key                  = "terraform.tfstate"
    resource_group_name  = "rg-backend-nice-chimp"
    storage_account_name = "sanicechimp"
  }
}