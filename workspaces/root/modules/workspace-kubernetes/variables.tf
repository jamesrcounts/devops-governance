variable "oauth_token_id" {
  description = "The TFC OAUTH token ID for the token that allows access to GitHub."
  type        = string
}

variable "organization_name" {
  description = "The TFC Organization for this workspace."
  type        = string
}

variable "tags" {
  description = "The workspace tag names."
  type        = list(string)
}

variable "repository_full_name" {
  description = "The repository full name for the VCS connection."
  type        = string
}

variable "workspace_directory" {
  description = "The directory containing a Terraform module to deploy."
  type        = string
}

variable "workspace_prefix" {
  description = "Used to generate workspace names."
  type        = string
}

variable "namespace" {
  description = "The project namespace."
  type        = string
}

variable "variables" {
  description = "The variable sets to attach to this workspace."
  type        = map(string)
}