resource "azuredevops_variable_group" "terraform_backend" {
  project_id   = azuredevops_project.project.id
  name         = "terraform-backend"
  description  = "Specifies the values for the AzureRM terraform backend."
  allow_access = false

  variable {
    name  = "TF_STORAGE_RG"
    value = var.backend.resource_group_name
  }

  variable {
    name  = "TF_STORAGE_ACCOUNT"
    value = var.backend.storage_account_name
  }

  variable {
    name  = "TF_STORAGE_BLOB_CONTAINER"
    value = var.backend.container_name
  }

  variable {
    name  = "TF_STORAGE_BLOB_NAME"
    value = var.backend.blob_name
  }
}
