module "azure_env" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-resource-group-env?ref=azure-resource-group-env-0.0.5"
  providers = {
    azurerm = azurerm.bo
  }

  location      = local.location
  required_tags = local.required_tags
  optional_tags = { backend_instance_id = module.azure_backend.resource_group.tags["instance_id"] }
}