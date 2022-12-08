locals {
  project = "${var.workspace_prefix}-${var.namespace}"
}

resource "azuredevops_project" "project" {
  description        = "${local.project} (Managed by Terraform)"
  name               = local.project
  version_control    = "Git"
  visibility         = "private"
  work_item_template = "Agile"
}

resource "azuredevops_project_features" "features" {
  project_id = azuredevops_project.project.id
  features = {
    "artifacts"    = "disabled"
    "boards"       = "disabled"
    "pipelines"    = "enabled"
    "repositories" = "disabled"
    "testplans"    = "disabled"
  }
}