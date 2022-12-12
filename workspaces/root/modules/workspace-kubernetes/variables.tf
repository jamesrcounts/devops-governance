variable "environment" {
  description = "The workspace environment tier."
  type        = string

  validation {
    condition     = contains(["dev", "prd"], var.environment)
    error_message = "Must be one of: dev, prd."
  }
}

variable "namespace" {
  description = "The project namespace."
  type        = string
}

variable "oauth_token_id" {
  description = "The TFC OAUTH token ID for the token that allows access to GitHub."
  type        = string
}

variable "organization_name" {
  description = "The TFC Organization for this workspace."
  type        = string
}

variable "repository_full_name" {
  description = "The repository full name for the VCS connection."
  type        = string
}

variable "tags" {
  description = "The workspace tag names."
  type        = list(string)
}

variable "variables" {
  description = "The variable sets to attach to this workspace."
  type        = map(string)
}

variable "workspace_directory" {
  description = "The directory containing a Terraform module to deploy."
  type        = string
}

variable "workspace_prefix" {
  description = "Used to generate workspace names."
  type        = string
}
