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

resource "azuread_application" "app" {
  display_name                   = "Terraform Root (Managed by Terraform)"
  fallback_public_client_enabled = false
  prevent_duplicate_names        = true
  sign_in_audience               = "AzureADMyOrg"

  web {
    implicit_grant {
      access_token_issuance_enabled = false
    }
  }
}

resource "time_static" "now" {}

resource "azuread_application_password" "password" {
  application_object_id = azuread_application.app.id
  display_name          = "Managed by Terraform"
  end_date              = timeadd(time_static.now.rfc3339, "240h")
}

data "azurerm_subscription" "current" {}

resource "azuread_service_principal" "sp" {
  app_role_assignment_required = false
  application_id               = azuread_application.app.application_id
}

resource "azuread_directory_role" "administrator" {
  display_name = "Global Administrator"
}

resource "azuread_directory_role_assignment" "assignments" {
  role_id             = azuread_directory_role.administrator.object_id
  principal_object_id = azuread_service_principal.sp.object_id
}

resource "azurerm_role_assignment" "owner" {
  principal_id         = azuread_service_principal.sp.object_id
  role_definition_name = "Owner"
  scope                = data.azurerm_subscription.current.id
}

resource "azurerm_role_assignment" "keyvault_manager" {
  principal_id         = azuread_service_principal.sp.object_id
  role_definition_name = "Key Vault Administrator"
  scope                = data.azurerm_subscription.current.id
}

resource "azurerm_role_assignment" "blob_owner" {
  principal_id         = azuread_service_principal.sp.object_id
  role_definition_name = "Storage Blob Data Owner"
  scope                = data.azurerm_subscription.current.id
}

module "variable" {
  source = "./modules/variables"

  for_each = {
    azure = {
      description = "Azure service principal credentials."
      variables = {
        client_id = {
          description = "The AzureAD Appication Client ID"
          value       = azuread_application.app.application_id
        }
        client_secret = {
          description = "The AzureAD Application Password"
          sensitive   = true
          value       = azuread_application_password.password.value
        }
        subscription_id = {
          description = "The Azure subscription ID"
          value       = data.azurerm_subscription.current.subscription_id
        }
        subscription_name = {
          description = "The Azure subscription name."
          value       = data.azurerm_subscription.current.display_name
        }
        tenant_id = {
          description = "The Azure AD tenant ID"
          value       = data.azurerm_subscription.current.tenant_id
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

## Workspace

resource "tfe_workspace" "root" {
  description       = "Use the root worksapce to create additional workspaces."
  name              = "root"
  organization      = tfe_organization.org.name
  tag_names         = ["workspaces", "root"]
  terraform_version = "~> 1.3.6"
  working_directory = "workspaces/root"
  execution_mode    = "local"

  vcs_repo {
    identifier     = "jamesrcounts/devops-governance"
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "github" {
  for_each = module.variable

  variable_set_id = each.value.id
  workspace_id    = tfe_workspace.root.id
}