locals {
  workspace_directory = "infrastructure/stages/base"
  workspace_name      = "container-pipelines-${local.namespace}"
  namespace           = random_pet.instance_id.id

  variable = {
    azure = module.rg_credentials.service_principal
    azure_env = {
      description = "Azure Environment Configuration for ${local.namespace}"
      variables = {
        resource_group_name = {
          description = "The resource group this workspace will manage."
          value       = module.rg.name
        }
      }
    }
  }
}

resource "random_pet" "instance_id" {}

module "repository" {
  source = "../github-repository"

  name = local.workspace_name

  template = {
    owner      = "jamesrcounts"
    repository = "phippyandfriends"
  }
}

module "rg" {
  source = "../resource-group"

  namespace = local.namespace

  repository = {
    name                = module.repository.full_name
    workspace_directory = local.workspace_directory
  }

}

module "rg_credentials" {
  source = "../azure-credential"

  scope        = module.rg.id
  subscription = var.subscription
  workspace    = local.namespace
}

module "variable" {
  source   = "../variables"
  for_each = local.variable

  description       = each.value.description
  name              = "${replace(each.key, "_", "-")}-${local.namespace}"
  organization_name = var.organization_name
  variables         = each.value.variables
}

resource "tfe_workspace" "ws" {
  force_delete      = true
  name              = local.workspace_name
  organization      = var.organization_name
  tag_names         = ["terraform", "pipelines"]
  terraform_version = "~> 1.3.6"
  working_directory = "/${local.workspace_directory}"

  vcs_repo {
    identifier     = module.repository.full_name
    oauth_token_id = var.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "workspace_variables" {
  for_each = module.variable

  variable_set_id = each.value.id
  workspace_id    = tfe_workspace.ws.id
}