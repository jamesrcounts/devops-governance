locals {
  # Manual check for null because the count may not be known.
  acrs = var.container_registry == null ? [] : ["acr"]
}

resource "azuredevops_serviceendpoint_azurecr" "endpoint" {
  for_each = toset(local.acrs)

  azurecr_name              = var.container_registry.acr_name
  azurecr_spn_tenantid      = var.service_principal.tenant_id
  azurecr_subscription_id   = var.service_principal.subscription_id
  azurecr_subscription_name = var.service_principal.subscription_name
  description               = "Managed by Terraform"
  project_id                = azuredevops_project.project.id
  resource_group            = var.container_registry.resource_group_name
  service_endpoint_name     = "ACR"
}