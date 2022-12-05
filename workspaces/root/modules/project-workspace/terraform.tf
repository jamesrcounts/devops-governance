
resource "tfe_workspace" "ws" {
  depends_on = [module.variable]

  force_delete      = true
  name              = "${each.key}-${local.namespace}"
  organization      = var.organization_name
  tag_names         = ["terraform", "pipelines"]
  terraform_version = "~> 1.3.6"
  working_directory = "/${var.workspace_directory}"

  vcs_repo {
    identifier     = var.repository.full_name
    oauth_token_id = var.oauth_token_id
  }
}

module "workspace_variables" {
  source   = "../workspace-variables"
  for_each = tfe_workspace.ws

  variables    = module.variable
  workspace_id = each.value.id
}
