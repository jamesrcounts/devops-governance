module "azure_env" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-resource-group-env?ref=aks-istio"

  config_key_vault_id = module.azure_backend.key_vault.id
  location            = local.location

  required_tags = merge(
    local.env_tags,
    {
      purpose = "appenv"
    }
  )
}

module "azure_hub" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-resource-group-env?ref=aks-istio"

  config_key_vault_id = module.azure_backend.key_vault.id
  location            = local.location

  required_tags = merge(
    local.env_tags,
    {
      purpose = "networking"
    }
  )
}