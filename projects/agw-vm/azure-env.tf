module "azure_env" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-resource-group-env?ref=main"

  providers = {
    azurerm = azurerm.env
  }

  location = local.location
  required_tags = merge(
    local.required_tags,
    {
      backend_instance_id = module.azure_backend.resource_group.tags["instance_id"]
      purpose             = "appenv"
    }
  )
}