## Org level
resource "tfe_organization" "org" {
  email = "jamesrcounts@outlook.com"
  name  = "olive-mercury"
}

resource "tfe_oauth_client" "github" {
  organization     = tfe_organization.org.name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_pat
  service_provider = "github"
}

data "azurerm_subscription" "current" {}

module "administrator" {
  source = "./modules/azure-credential"

  roles        = ["Global Administrator"]
  scope        = data.azurerm_subscription.current.id
  subscription = data.azurerm_subscription.current
  workspace    = "root"
}

module "variable" {
  source = "./modules/variables"

  for_each = {
    azure = {
      description = "Azure service principal credentials."
      variables = {
        client_id = {
          description = "The AzureAD Appication Client ID"
          value       = module.administrator.client_id
        }
        client_secret = {
          description = "The AzureAD Application Password"
          sensitive   = true
          value       = module.administrator.client_secret
        }
        subscription_id = {
          description = "The Azure subscription ID"
          value       = module.administrator.subscription_id
        }
        tenant_id = {
          description = "The Azure AD tenant ID"
          value       = module.administrator.tenant_id
        }
      }
    }
    github = {
      description = "GitHub credentials."
      variables = {
        github_pat = {
          description = "GitHub Personal Access Token"
          sensitive   = true
          value       = var.github_pat
        }
      }
    }
    tfe = {
      description = "Terraform Cloud credetials."
      variables = {
        tfe_token = {
          sensitive   = true
          description = "Terraform Cloud API Token"
          value       = var.tfe_token
        }
      }
    }
  }

  description       = each.value.description
  name              = each.key
  organization_name = tfe_organization.org.name
  variables         = each.value.variables
}

## Root Workspace

resource "tfe_workspace" "root" {
  description       = "Use the root worksapce to create additional workspaces."
  name              = "root"
  organization      = tfe_organization.org.name
  tag_names         = ["workspaces", "root"]
  terraform_version = "~> 1.3.6"
  working_directory = "workspaces/root"

  vcs_repo {
    identifier     = "jamesrcounts/devops-governance"
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "workspace_variables" {
  for_each = module.variable

  variable_set_id = each.value.id
  workspace_id    = tfe_workspace.root.id
}

# Project Workspaces
locals {
  workspace = {
    terraform-pipelines-demo = {
      enabled = true
      template_repository = {
        owner      = "jamesrcounts"
        repository = "terraform-getting-started-azure"
      }
    }
    container-pipelines-demo = {
      enabled = true
      template_repository = {
        owner      = "jamesrcounts"
        repository = "phippyandfriends"
        roles      = ["Directory Readers", "Groups Administrator"]
      }
    }
  }
}

module "workspace" {
  source = "./modules/project-workspace"

  for_each = { for k, v in local.workspace : k => v if v.enabled }

  oauth_token_id      = tfe_oauth_client.github.oauth_token_id
  organization_name   = tfe_organization.org.name
  roles               = lookup(each.value, "roles", [])
  subscription        = data.azurerm_subscription.current
  template_repository = each.value.template_repository
}