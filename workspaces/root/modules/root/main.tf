locals {
  variable = {
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
}

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

module "administrator" {
  source = "../azure-credential"

  roles        = ["Global Administrator"]
  scope        = var.subscription.id
  subscription = var.subscription
  workspace    = "root"
}

module "variable" {
  source   = "../variables"
  for_each = local.variable

  description       = each.value.description
  name              = each.key
  organization_name = tfe_organization.org.name
  variables         = each.value.variables
}


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
