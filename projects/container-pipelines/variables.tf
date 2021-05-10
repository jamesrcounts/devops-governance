variable "aad_script_name" {
  default     = null
  description = "(Optional) When provided a filename this module will write a powershell script to assign AAD roles to these credentials.  Defaults to null."
  type        = string
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