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

variable "template_repository" {
  description = "The repository to copy seed code from."
  type = object({
    owner      = string
    repository = string
  })
}

variable "workspace_directories" {
  default     = []
  description = "The terraform directories that include deployable terraform modules."
  type        = list(string)
}