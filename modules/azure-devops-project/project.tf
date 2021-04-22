resource "azuredevops_project" "project" {
  description        = "${var.project} (Managed by Terraform)"
  name               = var.project
  version_control    = "Git"
  visibility         = "private"
  work_item_template = "Agile"
}