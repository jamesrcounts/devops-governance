resource "azuredevops_serviceendpoint_azurerm" "connection" {
  azurerm_spn_tenantid      = module.azure_credentials.service_principal.tenant_id
  azurerm_subscription_id   = data.azurerm_subscription.env.subscription_id
  azurerm_subscription_name = data.azurerm_subscription.env.display_name
  description               = "Managed by Terraform"
  project_id                = module.azure_devops_pipelines.devops_project_id
  service_endpoint_name     = "Azure"

  credentials {
    serviceprincipalid  = module.azure_credentials.service_principal.client_id
    serviceprincipalkey = module.azure_credentials.service_principal.client_secret
  }
}
