resource "azuredevops_project" "project" {
  description        = "${var.project} (Managed by Terraform)"
  name               = var.project
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