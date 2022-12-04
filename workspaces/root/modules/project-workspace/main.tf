locals {
  name                         = "tf-gs-${local.namespace}"
  namespace                    = random_pet.instance_id.id
  repository_working_directory = "infrastructure"
}

data "azurerm_subscription" "current" {}

resource "random_pet" "instance_id" {}

# Workspaces connect Terraform Cloud workspaces to a repository and an environment.

# Repository in GitHub
resource "github_repository" "repository" {
  archive_on_destroy     = false
  delete_branch_on_merge = true
  has_downloads          = false
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  name                   = local.name
  visibility             = "public"

  template {
    owner                = "jamesrcounts"
    repository           = "terraform-getting-started-azure"
    include_all_branches = true
  }
}

# Environment in Azure
resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.namespace}"
  location = "centralus"

  tags = {
    repository = "${github_repository.repository.full_name}/${local.repository_working_directory}"
    workspace  = local.name
  }
}

# Workspace (Backend and Pipelines) in TFC.
resource "tfe_workspace" "ws" {
  name              = local.name
  organization      = var.organization_name
  tag_names         = ["terraform", "pipelines"]
  terraform_version = "~> 1.3.6"
  working_directory = "/${local.repository_working_directory}"

  vcs_repo {
    identifier     = github_repository.repository.full_name
    oauth_token_id = var.oauth_token_id
  }
}

module "variable" {
  source = "../variables"

  for_each = {
    azure_env = {
      description = "Azure Environment Configuration for ${local.name}"
      variables = {
        resource_group_name = {
          description = "The resource group this workspace will manage."
          value       = azurerm_resource_group.rg.name
        }
        env_subscription_id = {
          description = "The subscription containing the resource group this workspace will manage."
          value       = data.azurerm_subscription.current.id
        }
      }
    }
  }

  description       = each.value.description
  name              = "${replace(each.key, "_", "-")}-${local.name}"
  organization_name = var.organization_name
  variables         = each.value.variables
}

resource "tfe_workspace_variable_set" "workspace_variables" {
  for_each = module.variable

  variable_set_id = each.value.id
  workspace_id    = tfe_workspace.ws.id
}