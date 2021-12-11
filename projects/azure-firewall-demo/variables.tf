variable "github_pat" {
  description = "(Required) A GitHub personal access token. Used to configure an Azure DevOps service connection."
  sensitive   = true
  type        = string
}

variable "repository" {
  description = "(Required) The repository id for the Terraform project."
  type        = string
}