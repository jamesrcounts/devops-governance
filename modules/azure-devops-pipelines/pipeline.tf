resource "azuredevops_build_definition" "build" {
  project_id = azuredevops_project.project.id
  name       = var.project

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type             = "GitHub"
    repo_id               = var.repository
    branch_name           = "main"
    yml_path              = "azure-pipelines.yml"
    service_connection_id = azuredevops_serviceendpoint_github.endpoint.id
  }
}