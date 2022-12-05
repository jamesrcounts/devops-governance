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