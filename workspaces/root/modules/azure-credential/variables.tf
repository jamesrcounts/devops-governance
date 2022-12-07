variable "roles" {
  default     = []
  description = "AzureAD Roles to Assing to the credentials."
  type        = list(string)
}

variable "scope" {
  description = "The ownership scope for these credentials."
  type        = string
}

variable "subscription" {
  description = "The subscription scope for these credentials."
  type = object({
    display_name    = string
    id              = string
    subscription_id = string
    tenant_id       = string
  })
}

variable "workspace" {
  description = "The workspace that will use the credential."
  type        = string
}
