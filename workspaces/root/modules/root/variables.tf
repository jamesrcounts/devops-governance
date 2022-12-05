variable "github_pat" {
  description = "A github personal access token to create the VCS connection."
  sensitive   = true
  type        = string
}

variable "subscription" {
  description = "The subscription managed by the root workspace."
  type = object({
    id              = string
    display_name    = string
    tenant_id       = string
    subscription_id = string
  })
}

variable "tfe_token" {
  description = "A Terraform Cloud token to manage the organization."
  sensitive   = true
  type        = string
}