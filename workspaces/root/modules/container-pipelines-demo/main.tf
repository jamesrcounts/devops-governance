locals {
  variable = {
    azure_ops_env = {
      description = "Azure Ops Environment Configuration for ${module.terraform_pipelines_demo.namespace}"
      variables = {
        resource_group_name = {
          description = "The ops resource group associated with this workspace."
          value       = module.rg_ops.name
        }
        ops_subscription_id = {
          description = "The subscription ID containing this project's ops resources"
          value       = var.subscription.id
        }
      }
    }
  }
}

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

# Additional Resource Group
module "rg_ops" {
  source = "../resource-group"

  namespace = "ops-${module.terraform_pipelines_demo.namespace}"

  repository = {
    name                = module.terraform_pipelines_demo.repository_full_name
    workspace_directory = module.terraform_pipelines_demo.workspace_directory
  }
}

module "variable" {
  source   = "../variables"
  for_each = local.variable

  description       = each.value.description
  name              = "${replace(each.key, "_", "-")}-${module.terraform_pipelines_demo.namespace}"
  organization_name = var.organization_name
  variables         = each.value.variables
}