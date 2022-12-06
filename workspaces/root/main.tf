locals {

  # environments
  workspace = {
    terraform-pipelines = {
      enabled             = true
      repository          = "terraform-pipelines"
      workspace_directory = "infrastructure"
    }
    container-pipelines-base = {
      enabled             = false
      roles               = ["Directory Readers", "Groups Administrator"]
      repository          = "container-pipelines"
      workspace_directory = "infrastructure/stages/base"
    }
    container-pipelines-dev = {
      enabled             = false
      repository          = "container-pipelines"
      workspace_directory = "infrastructure/stages/kubernetes-dev"
    }
    container-pipelines-prd = {
      enabled             = false
      repository          = "container-pipelines"
      workspace_directory = "infrastructure/stages/kubernetes-prd"
    }
  }
}

data "azurerm_subscription" "current" {}

## Root Organization & Workspace
module "root" {
  source = "./modules/root"

  github_pat   = var.github_pat
  subscription = data.azurerm_subscription.current
  tfe_token    = var.tfe_token
}

# Project Repositories
module "terraform_pipelines_demo" {
  source = "./modules/terraform-pipelines-demo"

  oauth_token_id    = module.root.oauth_token_id
  organization_name = module.root.tfc_organization.name
  subscription      = data.azurerm_subscription.current
}

# module "container_pipelines_demo" {
#   source = "./modules/container-pipelines-demo"

#   oauth_token_id    = module.root.oauth_token_id
#   organization_name = module.root.tfc_organization.name
#   subscription      = data.azurerm_subscription.current
# }

# module "workspace" {
#   source = "./modules/project-workspace"

#   for_each = { for k, v in local.workspace : k => v if v.enabled }

#   oauth_token_id        = module.root.oauth_token_id
#   organization_name     = module.root.tfc_organization.name
#   roles                 = lookup(each.value, "roles", [])
#   subscription          = data.azurerm_subscription.current
#   repository            = github_repository.repository[each.value.repository]
#   workspace_directory = each.value.workspace_directory
# }