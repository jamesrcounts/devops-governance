module "azure_env" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-resource-group-env?ref=aks-istio"

  location      = local.location
  required_tags = local.required_tags
  optional_tags = {
    backend_instance_id = module.azure_backend.resource_group.tags["instance_id"]
    role                = "spoke"
  }
}

module "azure_hub" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-resource-group-env?ref=aks-istio"

  location      = local.location
  required_tags = local.required_tags
  optional_tags = {
    backend_instance_id = module.azure_backend.resource_group.tags["instance_id"]
    role                = "hub"
  }
}