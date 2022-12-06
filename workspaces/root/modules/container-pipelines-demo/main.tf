module "terraform_pipelines_demo" {
  source = "../workspace-azure-rg"

  oauth_token_id      = var.oauth_token_id
  organization_name   = var.organization_name
  subscription        = var.subscription
  workspace_directory = "infrastructure/stages/base"
  workspace_prefix    = "container-pipelines"

  template = {
    owner      = "jamesrcounts"
    repository = "phippyandfriends"
  }
}