variable "config_key_vault_id" {
  description = "(Required) Specifies the Key Vault to store configuration data in."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "required_tags" {
  description = "(Required) Tags to assign to each resource."
  type = object({
    backend_instance_id = string
    project             = string
    purpose             = string
    repository          = string
  })
}

variable "optional_tags" {
  default     = {}
  description = "(Optional) Tags to assign to each resource."
  type        = map(string)
}