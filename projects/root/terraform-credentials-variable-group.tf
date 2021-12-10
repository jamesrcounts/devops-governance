resource "azuredevops_variable_group" "tfc" {
  project_id   = module.azure_devops_pipelines.devops_project_id
  name         = "terraform-cloud"
  description  = "Specifies the credentials for the Terraform Cloud provider."
  allow_access = false

  variable {
    is_secret    = true
    name         = "TFE_TOKEN"
    secret_value = var.tfe_token
  }
}