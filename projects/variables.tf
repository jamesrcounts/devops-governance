variable "azuredevops_pat" {
  description = "(Required) An Azure DevOps personal access token. Used to configure a variable group for the Azure DevOps Terraform Provider."
  sensitive   = true
  type        = string
}

variable "azuredevops_url" {
  description = "(Required) An Azure DevOps organization URL. Used to configure a variable group for the Azure DevOps Terraform Provider."
  type        = string
}

variable "aws_access_key_id" {
  description = "(Required) Specifies the AWS access key ID for the AWS Terraform provider."
  type        = string
}

variable "aws_secret_access_key" {
  description = "(Required) Specifies the AWS access key secret for the AWS Terraform provider."
  sensitive   = true
  type        = string
}

variable "generate_scripts" {
  default     = false
  description = "(Optional) A flag to indicate whether to generate run-once scripts."
  type        = bool
}

variable "github_pat" {
  description = "(Required) A GitHub personal access token. Used to configure an Azure DevOps service connection."
  sensitive   = true
  type        = string
}