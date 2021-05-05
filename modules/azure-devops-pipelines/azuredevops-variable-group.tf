locals {
  # Manual check for null because azuredevops is marked sensitive.
  azure_devops_credentials = var.azuredevops == null ? [] : ["pat"]
}

resource "azuredevops_variable_group" "azuredevops" {
  for_each = toset(local.azure_devops_credentials)

  project_id   = azuredevops_project.project.id
  name         = "azuredevops"
  description  = "Specifies the credentials for the Azure DevOps Terraform provider."
  allow_access = false

  variable {
    is_secret    = true
    name         = "AZUREDEVOPS_PAT"
    secret_value = var.azuredevops.pat
  }

  variable {
    name  = "AZUREDEVOPS_URL"
    value = var.azuredevops.url
  }
}
