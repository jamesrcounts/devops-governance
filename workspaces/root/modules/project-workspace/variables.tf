variable "oauth_token_id" {
  description = "The TFC OAUTH token ID for the token that allows access to GitHub."
  type        = string
}

variable "organization_name" {
  description = "The TFC Organization for this workspace."
  type        = string
}

variable "roles" {
  default     = []
  description = "AzureAD Roles to Assing to the workspace."
  type        = list(string)
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

variable "repository" {
  description = "The workspace repository."
  type = object({
    full_name = string
  })
}

variable "workspace_directory" {
  description = "The terraform module directory."
  type        = string
}