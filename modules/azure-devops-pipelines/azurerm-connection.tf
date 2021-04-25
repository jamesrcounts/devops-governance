resource "azuredevops_serviceendpoint_azurerm" "connection" {
  azurerm_spn_tenantid      = var.service_principal.tenant_id
  azurerm_subscription_id   = var.service_principal.subscription_id
  azurerm_subscription_name = var.service_principal.subscription_name
  description               = "Managed by Terraform"
  project_id                = azuredevops_project.project.id
  service_endpoint_name     = "Azure"

  credentials {
    serviceprincipalid  = var.service_principal.client_id
    serviceprincipalkey = var.service_principal.client_secret
  }
}
