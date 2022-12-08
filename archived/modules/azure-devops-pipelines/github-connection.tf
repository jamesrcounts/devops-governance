resource "azuredevops_serviceendpoint_github" "endpoint" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "GithHub Personal Access Token"

  auth_personal {
    personal_access_token = var.github_pat
  }
}