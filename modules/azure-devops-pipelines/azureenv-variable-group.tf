locals {
  # Manual check for null because the count may not be known.
  azure_env_vars = var.azure_env == null ? [] : ["vars"]
}

resource "azuredevops_variable_group" "azureenv" {
  for_each = toset(local.azure_env_vars)

  allow_access = false
  description  = "Specifies the target environment for the Terraform configuration."
  name         = "azure-env"
  project_id   = azuredevops_project.project.id

  dynamic "variable" {
    for_each = var.azure_env
    content {
      name  = variable.key
      value = variable.value
    }
  }
}
