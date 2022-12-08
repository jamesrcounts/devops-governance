resource "azuread_group" "aks_administrators" {
  display_name = "aks-${module.azure_env.instance_id}-administrators"
  description  = "Kubernetes administrators for the ${module.azure_env.instance_id} cluster."
}
