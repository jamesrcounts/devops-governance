variable "aws" {
  description = "(Required) Specifies the credentials for the AWS Terraform provider."
  sensitive   = true
  type = object({
    id  = string
    key = string
  })
}

variable "github_pat" {
  description = "(Required) A GitHub personal access token. Used to configure an Azure DevOps service connection."
  sensitive   = true
  type        = string
}

variable "project" {
  description = "(Required) The project name."
  type        = string
}

variable "repository" {
  description = "(Required) The repository id for the Terraform project."
  type        = string
}