locals {
  #   workspace_directory = "infrastructure"
  workspace_name = "container-pipelines-${local.namespace}"
  namespace      = random_pet.instance_id.id

  #   variable = {
  #     azure = module.rg_credentials.service_principal
  #     azure_env = {
  #       description = "Azure Environment Configuration for ${local.namespace}"
  #       variables = {
  #         resource_group_name = {
  #           description = "The resource group this workspace will manage."
  #           value       = azurerm_resource_group.rg.name
  #         }
  #       }
  #     }
  #   }
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