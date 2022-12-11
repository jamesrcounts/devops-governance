locals {
  location = "centralus"

  variable = {
    azure_ops_env = {
      description = "Azure Ops Environment Configuration for ${module.workspace.namespace}"
      variables = {
        ops_resource_group_name = {
          description = "The ops resource group associated with this workspace."
          value       = module.rg_ops.name
        }
        ops_subscription_id = {
          description = "The subscription ID containing this project's ops resources"
          value       = var.subscription.subscription_id
        }
      }
    }
  }
}

module "workspace" {
  source = "../workspace-azure-rg"

  oauth_token_id      = var.oauth_token_id
  organization_name   = var.organization_name
  roles               = ["Directory Readers", "Groups Administrator"]
  subscription        = var.subscription
  tags                = ["container", "pipelines", "base"]
  workspace_directory = "infrastructure/stages/base"
  workspace_prefix    = "container-pipelines"
  location            = local.location

  template = {
    owner      = "jamesrcounts"
    repository = "phippyandfriends"
  }
}

module "kubernetes-workspace" {
  source   = "../workspace-kubernetes"
  for_each = toset(["dev", "prd"])

  namespace            = module.workspace.namespace
  oauth_token_id       = var.oauth_token_id
  organization_name    = var.organization_name
  repository_full_name = module.workspace.repository_full_name
  tags                 = ["container", "pipelines", "kubernetes"]
  variables            = merge({ azure_ops_env = module.variable["azure_ops_env"].id }, module.workspace.variable_set)
  workspace_directory  = "infrastructure/stages/kubernetes-${each.key}"
  workspace_prefix     = "kubernetes-${each.key}"
}

module "azure-devops-project" {
  source = "../azure-devops-project"

  namespace        = module.workspace.namespace
  workspace_prefix = "container-pipelines"
}

resource "azuredevops_serviceendpoint_azurecr" "acr" {
  azurecr_name              = azurerm_container_registry.basic.name
  azurecr_spn_tenantid      = var.subscription.tenant_id
  azurecr_subscription_id   = var.subscription.subscription_id
  azurecr_subscription_name = var.subscription.display_name
  description               = "Managed by Terraform"
  project_id                = module.azure-devops-project.id
  resource_group            = azurerm_container_registry.basic.resource_group_name
  service_endpoint_name     = "ACR"
}

resource "azuredevops_resource_authorization" "allow_acr" {
  project_id  = module.azure-devops-project.id
  resource_id = azuredevops_serviceendpoint_azurecr.acr.id
  authorized  = true
}

resource "azuredevops_serviceendpoint_github" "github" {
  project_id            = module.azure-devops-project.id
  service_endpoint_name = "GithHub Personal Access Token"

  auth_personal {
    personal_access_token = var.github_pat
  }
}

resource "azuredevops_resource_authorization" "allow_github" {
  project_id  = module.azure-devops-project.id
  resource_id = azuredevops_serviceendpoint_github.github.id
  authorized  = true
}

resource "azuredevops_serviceendpoint_azurerm" "azure" {
  for_each                  = toset(["AzureEnv", "AzureOps"])
  azurerm_spn_tenantid      = var.subscription.tenant_id
  azurerm_subscription_id   = var.subscription.subscription_id
  azurerm_subscription_name = var.subscription.display_name
  description               = "Managed by Terraform"
  project_id                = module.azure-devops-project.id
  service_endpoint_name     = each.key

  credentials {
    serviceprincipalid  = module.workspace.rg_service_principal.client_id.value
    serviceprincipalkey = module.workspace.rg_service_principal.client_secret.value
  }
}

resource "azuredevops_resource_authorization" "allow_azure" {
  for_each = azuredevops_serviceendpoint_azurerm.azure

  project_id  = module.azure-devops-project.id
  resource_id = each.value.id
  authorized  = true
}

resource "azuredevops_variable_group" "acr" {
  allow_access = false
  description  = "Specifies the name of the Azure Container Registry."
  name         = "acr"
  project_id   = module.azure-devops-project.id

  dynamic "variable" {
    for_each = {
      CONTAINER_REGISTRY_NAME = azurerm_container_registry.basic.name
      LOGIN_SERVER            = "${azurerm_container_registry.basic.name}.azurecr.io"
    }

    content {
      name  = variable.key
      value = variable.value
    }
  }
}

resource "azuredevops_variable_group" "azureenv" {
  allow_access = false
  description  = "Specifies the target environment for software deployment."
  name         = "azure-env"
  project_id   = module.azure-devops-project.id

  dynamic "variable" {
    for_each = {
      AZURE_ENV_INSTANCE_ID = module.workspace.namespace
    }
    # AZURE_ENV_SUBSCRIPTION_ID = data.azurerm_client_config.env.subscription_id
    # AZURE_OPS_INSTANCE_ID     = module.azure_backend.resource_group.tags["instance_id"]
    # AZURE_OPS_SUBSCRIPTION_ID = data.azurerm_client_config.ops.subscription_id
    content {
      name  = variable.key
      value = variable.value
    }
  }
}

resource "azuredevops_environment" "env" {
  for_each = toset(["dev", "prd"])

  project_id = module.azure-devops-project.id
  name       = each.key
}

resource "azuredevops_build_definition" "pipeline" {
  for_each = {
    parrot-chart  = "parrot/azure-pipelines.helm.yaml"
    parrot-deploy = "parrot/azure-pipelines.deploy.yaml"
    parrot-docker = "parrot/azure-pipelines.docker.yaml"
  }

  name       = each.key
  project_id = module.azure-devops-project.id

  ci_trigger {
    use_yaml = true
  }

  repository {
    branch_name           = "main"
    repo_id               = module.workspace.repository_full_name
    repo_type             = "GitHub"
    service_connection_id = azuredevops_serviceendpoint_github.github.id
    yml_path              = each.value
  }
}