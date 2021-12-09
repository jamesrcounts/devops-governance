variable "aad_script_name" {
  default     = null
  description = "(Optional) When provided a filename this module will write a powershell script to assign AAD roles to these credentials.  Defaults to null."
  type        = string
}

variable "aws" {
  description = "(Required) Specifies the credentials for the AWS Terraform provider."
  sensitive   = true
  type = object({
    id  = string
    key = string
  })
}

variable "azuredevops_pat" {
  description = "(Required) An Azure DevOps personal access token. Used to configure the Azure DevOps Terraform Provider."
  sensitive   = true
  type        = string
}

variable "azuredevops_url" {
  description = "(Required) An Azure DevOps organization URL. Used to configure the Azure DevOps Terraform Provider."
  type        = string
}

variable "arm_env_subscription_id" {
  description = "(Required) An Azure subscription ID for the runtime environment."
  type        = string
}

variable "github_pat" {
  description = "(Required) A GitHub personal access token. Used to configure an Azure DevOps service connection."
  sensitive   = true
  type        = string
}