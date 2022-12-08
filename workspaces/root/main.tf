data "azurerm_subscription" "current" {}

## Root Organization & Workspace
module "root" {
  source = "./modules/root"

  github_pat   = var.github_pat
  subscription = data.azurerm_subscription.current
  tfe_token    = var.tfe_token

  ado = {
    token = var.azuredevops_pat
    url   = var.azuredevops_url
  }

  aws = {
    access_key_id     = var.aws_access_key_id
    secret_access_key = var.aws_secret_access_key
  }
}

# Project Workspaces
module "terraform_pipelines_demo" {
  source = "./modules/workspace-azure-rg"

  oauth_token_id      = module.root.oauth_token_id
  organization_name   = module.root.tfc_organization.name
  subscription        = data.azurerm_subscription.current
  tags                = ["terraform", "pipelines"]
  workspace_directory = "infrastructure"
  workspace_prefix    = "terraform-pipelines"
  location            = "centralus"

  template = {
    owner      = "jamesrcounts"
    repository = "terraform-getting-started-azure"
  }
}

module "container_pipelines_demo" {
  source = "./modules/container-pipelines-demo"

  aws_credentials   = module.root.variable_set["aws"]
  github_pat        = var.github_pat
  oauth_token_id    = module.root.oauth_token_id
  organization_name = module.root.tfc_organization.name
  subscription      = data.azurerm_subscription.current

  aws = {
    access_key_id     = var.aws_access_key_id
    secret_access_key = var.aws_secret_access_key
    region            = var.aws_region
  }
}