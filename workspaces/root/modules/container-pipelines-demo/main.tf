locals {
  location = "centralus"

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
          value       = var.subscription.subscription_id
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
  location            = local.location

  template = {
    owner      = "jamesrcounts"
    repository = "phippyandfriends"
  }
}

module "kubernetes-workspace" {
  source   = "../workspace-kubernetes"
  for_each = toset(["dev", "prd"])

  namespace            = module.workspace.namespace
  oauth_token_id       = var.oauth_token_id
  organization_name    = var.organization_name
  repository_full_name = module.workspace.repository_full_name
  tags                 = ["container", "pipelines", "kubernetes"]
  variables            = merge({ azure_ops_env = module.variable["azure_ops_env"].id }, module.workspace.variable_set)
  workspace_directory  = "infrastructure/stages/kubernetes-${each.key}"
  workspace_prefix     = "kubernetes-${each.key}"
}

module "azure-devops-project" {
  source = "../azure-devops-project"

}
