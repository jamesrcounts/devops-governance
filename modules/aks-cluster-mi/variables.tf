variable "resource_group" {
  description = "(Required) The resource group to deploy the policy into."
  type = object({
    id       = string
    name     = string
    location = string
    tags     = map(string)
  })
}

variable "scopes" {
  description = "(Required) The scopes the role assignments apply to."
  type = object({
    aks        = string
    networking = string
  })
}