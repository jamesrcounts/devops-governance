data "azurerm_subscription" "current" {}

## Root Organization & Workspace
module "root" {
  source = "./modules/root"

  github_pat   = var.github_pat
  subscription = data.azurerm_subscription.current
  tfe_token    = var.tfe_token
}

# # Project Workspaces
# locals {
#   workspace = {
#     terraform-pipelines-demo = {
#       enabled = false

#       workspace_directories = {
#         iac = "infrastructure"
#       }

#       template_repository = {
#         owner      = "jamesrcounts"
#         repository = "terraform-getting-started-azure"
#       }
#     }
#     container-pipelines-demo = {
#       enabled = false

#       workspace_directories = {
#         base = "infrastructure/stages/base",
#         dev  = "infrastructure/stages/kubernetes-dev",
#         prd  = "infrastructure/stages/kubernetes-prd",
#       }

#       template_repository = {
#         owner      = "jamesrcounts"
#         repository = "phippyandfriends"
#         roles      = ["Directory Readers", "Groups Administrator"]
#       }
#     }
#   }
# }

# module "workspace" {
#   source = "./modules/project-workspace"

#   for_each = { for k, v in local.workspace : k => v if v.enabled }

#   oauth_token_id        = module.root.oauth_token_id
#   organization_name     = module.root.tfc_organization.name
#   roles                 = lookup(each.value, "roles", [])
#   subscription          = data.azurerm_subscription.current
#   template_repository   = each.value.template_repository
#   workspace_directories = each.value.workspace_directories
# }