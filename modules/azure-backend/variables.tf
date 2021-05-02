variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "required_tags" {
  description = "(Required) Tags to assign to each resource."
  type = object({
    repository = string
    project    = string
  })
}

variable "optional_tags" {
  default     = {}
  description = "(Optional) Tags to assign to each resource."
  type        = map(string)
}

variable "backend_config_filename" {
  default     = null
  description = "(Optional) When provided a filename this module will write the backend config to that file in tfvars format.  Defaults to null."
}