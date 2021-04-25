# resource "azuredevops_build_definition" "build" {
#   project_id = azuredevops_project.project.id
#   name       = var.project

#   ci_trigger {
#     use_yaml = true
#   }

#   repository {
#     repo_type             = "GitHubEnterprise"
#     repo_id               = "<GitHub Org>/<Repo Name>"
#     github_enterprise_url = "https://github.company.com"
#     branch_name           = "main"
#     yml_path              = "azure-pipelines.yml"
#     service_connection_id = "..."
#   }
# }