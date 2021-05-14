resource "azuredevops_build_definition" "builds" {
  for_each = local.pipelines

  project_id = azuredevops_project.project.id
  name       = each.key

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type             = "GitHub"
    repo_id               = var.repository
    branch_name           = var.branch_name
    yml_path              = each.value
    service_connection_id = azuredevops_serviceendpoint_github.endpoint.id
  }
}