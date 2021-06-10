// variable "aad_script_name" {
//   default     = null
//   description = "(Optional) When provided a filename this module will write a powershell script to assign AAD roles to these credentials.  Defaults to null."
//   type        = string
// }

// variable "aws" {
//   description = "(Required) Specifies the credentials for the AWS Terraform provider."
//   sensitive   = true
//   type = object({
//     id  = string
//     key = string
//   })
// }

variable "github_pat" {
  description = "(Required) A GitHub personal access token. Used to configure an Azure DevOps service connection."
  sensitive   = true
  type        = string
}

variable "generate_scripts" {
  default     = false
  description = "(Optional) A flag to indicate whether to generate run-once scripts."
  type        = bool
}

variable "project" {
  description = "(Required) The project name."
  type        = string
}

variable "repository" {
  description = "(Required) The repository id for the Terraform project."
  type        = string
}