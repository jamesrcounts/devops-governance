

module "workspace_variables" {
  source   = "../workspace-variables"
  for_each = tfe_workspace.ws

  variables    = module.variable
  workspace_id = each.value.id
}
