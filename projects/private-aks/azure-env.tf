module "azure_env" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-resource-group-env?ref=aks-istio"

  location = local.location
  required_tags = merge(
    local.env_tags,
    {
      purpose = "spoke"
    }
  )
}

module "azure_hub" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-resource-group-env?ref=aks-istio"

  location = local.location
  required_tags = merge(
    local.env_tags,
    {
      purpose = "hub"
    }
  )
}