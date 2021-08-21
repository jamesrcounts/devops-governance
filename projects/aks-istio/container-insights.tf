resource "azurerm_log_analytics_solution" "insights" {
  solution_name         = "ContainerInsights"
  location              = module.azure_backend.resource_group.location
  resource_group_name   = module.azure_backend.resource_group.name
  workspace_resource_id = module.azure_backend.log_analytics_workspace.id
  workspace_name        = module.azure_backend.log_analytics_workspace.name
  tags                  = module.azure_backend.resource_group.tags

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}