variable "azuredevops_pat" {
  description = "(Required) An Azure DevOps personal access token. Used to configure an Azure DevOps service connection."
  sensitive   = true
}

variable "container_name" {
  description = "The storage account blob container containing the terraform state file."
  type        = string
}

variable "github_pat" {
  description = "(Required) A GitHub personal access token. Used to configure an Azure DevOps service connection."
  sensitive   = true
}

variable "key" {
  description = "The terraform state file blob name."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group containing the storage account that contains the terraform state file."
  type        = string
}

variable "storage_account_name" {
  description = "The storage account that contains the terraform state file."
  type        = string
}