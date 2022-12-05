locals {
  namespace = random_pet.instance_id.id
}

resource "random_pet" "instance_id" {}

resource "github_repository" "repository" {
  archive_on_destroy     = true
  delete_branch_on_merge = true
  has_downloads          = false
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  name                   = "terraform-pipelines-${local.namespace}"
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
    repository  = "${github_repository.repository.full_name}/infrastructure"
  }
}

module "rg_credentials" {
  source = "../azure-credential"

  scope        = azurerm_resource_group.rg.id
  subscription = var.subscription
  workspace    = local.namespace
}

module "variable" {
  source = "../variables"

  for_each = {
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

  description       = each.value.description
  name              = "${replace(each.key, "_", "-")}-${local.namespace}"
  organization_name = var.organization_name
  variables         = each.value.variables
}
