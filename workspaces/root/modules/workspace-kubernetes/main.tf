locals {
  workspace_name = "${var.workspace_prefix}-${var.namespace}"
}

resource "tfe_workspace" "ws" {
  force_delete      = true
  name              = local.workspace_name
  organization      = var.organization_name
  tag_names         = var.tags
  terraform_version = "~> 1.3.6"
  working_directory = "/${var.workspace_directory}"

  vcs_repo {
    identifier     = var.repository_full_name
    oauth_token_id = var.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "workspace_variables" {
  for_each = var.variables

  variable_set_id = each.value
  workspace_id    = tfe_workspace.ws.id
}