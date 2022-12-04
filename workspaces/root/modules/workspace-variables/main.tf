resource "tfe_workspace_variable_set" "workspace_variables" {
  for_each = var.variables

  variable_set_id = each.value.id
  workspace_id    = var.workspace_id
}