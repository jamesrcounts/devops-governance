locals {
  workspace_name = "${var.workspace_prefix}-${var.namespace}"

  # variable = {
  #   azure = module.rg_credentials.service_principal
  #   azure_env = {
  #     description = "Azure Environment Configuration for ${local.namespace}"
  #     variables = {
  #       resource_group_name = {
  #         description = "The resource group this workspace will manage."
  #         value       = module.rg.name
  #       }
  #     }
  #   }
  # }
}

# module "repository" {
#   source = "../github-repository"

#   name = local.workspace_name

#   template = var.template
# }

# module "rg" {
#   source = "../resource-group"

#   location  = var.location
#   namespace = local.namespace

#   repository = {
#     name                = module.repository.full_name
#     workspace_directory = var.workspace_directory
#   }
# }

# module "rg_credentials" {
#   source = "../azure-credential"

#   roles        = var.roles
#   scope        = module.rg.id
#   subscription = var.subscription
#   workspace    = local.namespace
# }

# module "variable" {
#   source   = "../variables"
#   for_each = local.variable

#   description       = each.value.description
#   name              = "${replace(each.key, "_", "-")}-${local.namespace}"
#   organization_name = var.organization_name
#   variables         = each.value.variables
# }

resource "tfe_workspace" "ws" {
  force_delete      = true
  name              = local.workspace_name
  organization      = var.organization_name
  tag_names         = var.tags
  terraform_version = "~> 1.3.6"
  working_directory = "/${var.workspace_directory}"

  vcs_repo {
    identifier     = var.repository_full_name
    oauth_token_id = var.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "workspace_variables" {
  for_each = var.variables

  variable_set_id = each.value
  workspace_id    = tfe_workspace.ws.id
}