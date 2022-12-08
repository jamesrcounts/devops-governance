variable "aws" {
  description = "The AWS credentials."
  sensitive   = true

  type = object({
    access_key_id     = string
    region            = string
    secret_access_key = string
  })
}

variable "aws_credentials" {
  description = "The ID for the variable set that contains AWS credentials."
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

variable "subscription" {
  description = "The subscription scope for this workspace."
  type = object({
    display_name    = string
    id              = string
    subscription_id = string
    tenant_id       = string
  })
}