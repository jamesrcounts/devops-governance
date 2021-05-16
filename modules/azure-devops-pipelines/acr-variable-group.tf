resource "azuredevops_variable_group" "acr" {
  for_each = toset(local.acrs)

  project_id   = azuredevops_project.project.id
  name         = "acr"
  description  = "Specifies the name of the Azure Container Registry."
  allow_access = false

  variable {
    name  = "CONTAINER_REGISTRY_NAME"
    value = var.container_registry.acr_name
  }

  variable {
    name  = "LOGIN_SERVER"
    value = "${var.container_registry.acr_name}.azurecr.io"
  }
}
