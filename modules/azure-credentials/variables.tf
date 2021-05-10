variable "aad_roles" {
  default     = []
  description = "(Optional) When provided a list of AAD roles this module will write a powershell script to assign those roles to these credentials.  Requried when `application_administrator_script_name` is set."
  type        = list(string)
}

variable "active_password" {
  description = "(Required) Indicates which password clients should use, primary or secondary."
  type        = string
}

variable "application_administrator_script_name" {
  default     = null
  description = "(Optional) When provided a filename this module will write a powershell script to assign Application Administrator role to these credentials.  Defaults to null."
  type        = string
}

variable "owner_scope" {
  description = "(Optional) A map of friendly names to resource ids that the principal created by this module will have Onwer rights to manage."
  type        = map(string)
}

variable "project" {
  description = "(Required) The project name.  Used to generate the names for the application registration and other objects."
  type        = string
}

variable "update_triggers" {
  description = "(Required) The update triggers control when each password value will change."
  type = object({
    primary   = string
    secondary = string
  })
}