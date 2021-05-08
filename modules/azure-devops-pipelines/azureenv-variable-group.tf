resource "azuredevops_variable_group" "azureenv" {
  for_each = toset(var.azure_env[*])

  allow_access = false
  description  = "Specifies the target environment for the Terraform configuration."
  name         = "azure-env"
  project_id   = azuredevops_project.project.id

  variable {
    name         = "AZURE_ENV_RG"
    secret_value = each.value.resource_group_name
  }
}
