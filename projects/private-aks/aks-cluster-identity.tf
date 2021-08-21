module "aks_cluster_identity" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/aks-cluster-mi?ref=main"

  resource_group = module.azure_backend.resource_group
  scopes = {
    aks        = module.azure_env.resource_group.id
    networking = module.azure_hub.resource_group.id
  }
}