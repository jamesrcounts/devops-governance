locals {
  variable = {
    azure_ops_env = {
      description = "Azure Ops Environment Configuration for ${module.workspace.namespace}"
      variables = {
        ops_resource_group_name = {
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

module "workspace" {
  source = "../workspace-azure-rg"

  oauth_token_id      = var.oauth_token_id
  organization_name   = var.organization_name
  roles               = ["Directory Readers", "Groups Administrator"]
  subscription        = var.subscription
  tags                = ["container", "pipelines", "base"]
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

  namespace = "ops-${module.workspace.namespace}"

  repository = {
    name                = module.workspace.repository_full_name
    workspace_directory = module.workspace.workspace_directory
  }
}

module "variable" {
  source   = "../variables"
  for_each = local.variable

  description       = each.value.description
  name              = "${replace(each.key, "_", "-")}-${module.workspace.namespace}"
  organization_name = var.organization_name
  variables         = each.value.variables
}

resource "tfe_workspace_variable_set" "workspace_variables" {
  for_each = module.variable

  variable_set_id = each.value.id
  workspace_id    = module.workspace.id
}

resource "tfe_workspace_variable_set" "shared_workspace_variables" {
  for_each = {
    aws = var.aws_credentials
  }

  variable_set_id = each.value
  workspace_id    = module.workspace.id
}