variable "oauth_token_id" {
  description = "The TFC OAUTH token ID for the token that allows access to GitHub."
  type        = string
}

variable "organization_name" {
  description = "The TFC Organization for this workspace."
  type        = string
}

variable "subscription" {
  description = "The subscription scope for this workspace."
  type = object({
    display_name    = string
    id              = string
    subscription_id = string
    tenant_id       = string
  })
}

variable "tags" {
  description = "The workspace tag names."
  type        = list(string)
}

variable "template" {
  description = "The module will seed this repository from the specified GitHub template repository."
  type = object({
    owner      = string
    repository = string
  })
}

variable "workspace_directory" {
  description = "The directory containing a Terraform module to deploy."
  type        = string
}

variable "workspace_prefix" {
  description = "Used to generate workspace names."
  type        = string
}