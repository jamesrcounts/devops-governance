resource "azuredevops_serviceendpoint_azurecr" "endpoint" {
  for_each = toset(var.container_registry[*])

  azurecr_name              = each.value.acr_name
  azurecr_spn_tenantid      = var.service_principal.tenant_id
  azurecr_subscription_id   = var.service_principal.subscription_id
  azurecr_subscription_name = var.service_principal.subscription_name
  description               = "Managed by Terraform"
  project_id                = azuredevops_project.project.id
  resource_group            = each.value.resource_group_name
  service_endpoint_name     = "ACR"
}