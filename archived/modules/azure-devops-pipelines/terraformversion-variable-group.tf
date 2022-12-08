resource "azuredevops_variable_group" "terraformversion" {
  project_id   = azuredevops_project.project.id
  name         = "terraform-version"
  description  = "Specifies the terraform version and signature."
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
