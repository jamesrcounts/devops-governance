module "variable" {
  source = "../variables"

  for_each = {
    azure = {
      description = "Azure service principal credentials."
      variables = {
        client_id = {
          description = "The AzureAD Appication Client ID"
          value       = module.rg_credentials.client_id
        }
        client_secret = {
          description = "The AzureAD Application Password"
          sensitive   = true
          value       = module.rg_credentials.client_secret
        }
        subscription_id = {
          description = "The Azure subscription ID"
          value       = module.rg_credentials.subscription_id
        }
        tenant_id = {
          description = "The Azure AD tenant ID"
          value       = module.rg_credentials.tenant_id
        }
      }
    }
    azure_env = {
      description = "Azure Environment Configuration for ${local.name}"
      variables = {
        resource_group_name = {
          description = "The resource group this workspace will manage."
          value       = azurerm_resource_group.rg.name
        }
      }
    }
  }

  description       = each.value.description
  name              = "${replace(each.key, "_", "-")}-${local.name}"
  organization_name = var.organization_name
  variables         = each.value.variables
}

resource "tfe_workspace" "ws" {
  depends_on = [module.variable]

  for_each = toset(var.workspace_directories)

  force_delete      = true
  name              = local.name
  organization      = var.organization_name
  tag_names         = ["terraform", "pipelines"]
  terraform_version = "~> 1.3.6"
  working_directory = "/${each.value}"

  vcs_repo {
    identifier     = github_repository.repository.full_name
    oauth_token_id = var.oauth_token_id
  }
}

module "workspace_variables" {
  source   = "../workspace-variables"
  for_each = tfe_workspace.ws

  variables    = module.variable
  workspace_id = each.value.id
}

