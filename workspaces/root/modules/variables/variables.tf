variable "description" {
  description = "The variable set description."
  type        = string
}

variable "name" {
  description = "The variable set name."
  type        = string
}

variable "organization_name" {
  description = "The organization the variable set belongs to."
  type        = string
}

variable "variables" {
  description = "The terraform variables to add to the variable set."
  type = map(object({
    description = string
    sensitive   = optional(bool, false)
    value       = string
  }))
}