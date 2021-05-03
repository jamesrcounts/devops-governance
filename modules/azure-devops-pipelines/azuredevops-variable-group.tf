resource "azuredevops_variable_group" "azuredevops" {
  for_each = toset(var.azuredevops[*])

  project_id   = azuredevops_project.project.id
  name         = "azuredevops"
  description  = "Specifies the credentials for the Azure DevOps Terraform provider."
  allow_access = false

  variable {
    is_secret    = true
    name         = "AZUREDEVOPS_PAT"
    secret_value = each.pat
  }

  variable {
    name  = "AZUREDEVOPS_URL"
    value = each.url
  }
}
