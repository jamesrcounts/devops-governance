resource "azuredevops_variable_group" "github" {
  project_id   = azuredevops_project.project.id
  name         = "github"
  description  = "Specifies the values for the GitHub service connection."
  allow_access = false

  variable {
    is_secret    = true
    name         = "GITHUB_PAT"
    secret_value = var.github_pat
  }
}
