locals {
  workspace_directory = "infrastructure"
  workspace_name      = "terraform-pipelines-${local.namespace}"
  namespace           = random_pet.instance_id.id

  variable = {
    azure = module.rg_credentials.service_principal
    azure_env = {
      description = "Azure Environment Configuration for ${local.namespace}"
      variables = {
        resource_group_name = {
          description = "The resource group this workspace will manage."
          value       = azurerm_resource_group.rg.name
        }
      }
    }
  }
}

resource "random_pet" "instance_id" {}

resource "github_repository" "repository" {
  archive_on_destroy     = true
  delete_branch_on_merge = true
  has_downloads          = false
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  name                   = local.workspace_name
  visibility             = "public"

  template {
    owner      = "jamesrcounts"
    repository = "terraform-getting-started-azure"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.namespace}"
  location = "centralus"

  tags = {
    instance_id = local.namespace
    repository  = "${github_repository.repository.full_name}/${local.workspace_directory}"
  }
}

module "rg_credentials" {
  source = "../azure-credential"

  scope        = azurerm_resource_group.rg.id
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
    identifier     = github_repository.repository.full_name
    oauth_token_id = var.oauth_token_id
  }
}
