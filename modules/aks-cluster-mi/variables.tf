variable "resource_group" {
  description = "(Required) The resource group to deploy the policy into."
  type = object({
    id       = string
    name     = string
    location = string
    tags     = map(string)
  })
}

variable "scope" {
  description = "(Required) The scope at which the role assignments apply to."
  type        = string
}