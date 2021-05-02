resource "azuredevops_variable_group" "terraformversion" {
  project_id   = azuredevops_project.project.id
  name         = "azuredevops"
  description  = "Specifies the credentials for the Azure DevOps Terraform provider."
  allow_access = false

  variable {
    name  = "TERRAFORM_DOWNLOAD_SHA"
    value = local.terraform_shas[var.terraform_version]
  }

  variable {
    name  = "TERRAFORM_VERSION"
    value = var.terraform_version
  }
}
