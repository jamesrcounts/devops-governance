// variable "github_pat" {
//   description = "(Required) A GitHub personal access token. Used to configure an Azure DevOps service connection."
//   sensitive   = true
//   type        = string
// }

// variable "generate_scripts" {
//   default     = false
//   description = "(Optional) A flag to indicate whether to generate run-once scripts."
//   type        = bool
// }

variable "project" {
  description = "(Required) The project name."
  type        = string
}

variable "repository" {
  description = "(Required) The repository id for the Terraform project."
  type        = string
}