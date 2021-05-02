variable "azuredevops_pat" {
  description = "(Required) An Azure DevOps personal access token. Used to configure the Azure DevOps Terraform Provider."
  sensitive   = true
  type        = string
}

variable "azuredevops_url" {
  description = "(Required) An Azure DevOps organization URL. Used to configure the Azure DevOps Terraform Provider."
  type        = string
}

variable "github_pat" {
  description = "(Required) A GitHub personal access token. Used to configure an Azure DevOps service connection."
  sensitive   = true
  type        = string
}