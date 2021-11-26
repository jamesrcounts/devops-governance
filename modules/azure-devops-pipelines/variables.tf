variable "azuredevops" {
  description = "(Optional) Azure DevOps provider configuration. When present, this module will create a variable group containing these credentials."
  default     = null
  sensitive   = true
  type = object({
    pat = string
    url = string
  })
}

variable "azure_env" {
  description = "(Optional) Azure environment configuration. When present, this module will create a variable group containing this information."
  default     = null
  type        = map(string)
}

variable "backend" {
  description = "(Required) The AzureRM backend configuration for this Terraform pipeline."
  type = object({
    blob_name            = string
    container_name       = string
    storage_account_name = string
    resource_group_name  = string
  })
}

variable "branch_name" {
  default     = "main"
  description = "(Optional) The branch name for which builds are triggered. Defaults to main."
  type        = string
}

variable "config_keyvault" {
  default     = null
  description = "(Optional) The resource group and name of an Azure Key Vault. Used to configure a variable group. Defaults to null."
  type = object({
    key_vault_name      = string
    resource_group_name = string
  })
}

variable "container_registry" {
  default     = null
  description = "(Optional) The resource group and name of an Azure Container Registry. Used to configure a container registry service connection. Defaults to null."
  type = object({
    acr_name            = string
    resource_group_name = string
  })
}

variable "github_pat" {
  description = "(Required) A GitHub personal access token. Used to configure an Azure DevOps service connection."
  sensitive   = true
}

variable "project" {
  description = "(Required) Specifies the Azure DevOps project name."
  type        = string
}

variable "repository" {
  description = "(Required) The repository id."
  type        = string
}

variable "service_principal" {
  description = "(Required) An Azure service principal.  Used to configure a an AzureRM service connection in Azure DevOps."
  sensitive   = true
  type = object({
    client_id         = string
    client_secret     = string
    subscription_id   = string
    subscription_name = string
    tenant_id         = string
  })
}

variable "terraform_version" {
  default     = "1.0.11"
  description = "(Optional) The version of terraform to use.  Valid values are: '[0.15.1, 0.15.3, 0.15.4, 1.0.0, 1.0.1, 1.0.4, 1.0.11]'.  Defaults to '1.0.4'."
  type        = string
}

variable "pipelines" {
  default     = null
  description = "(Optional) Additional pipelines to create in the Azure DevOps project. Keys will be used as pipeline names, values as the path to the pipeline YAML."
  type        = map(string)
}