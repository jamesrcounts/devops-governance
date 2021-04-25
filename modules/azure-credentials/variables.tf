variable "active_password" {
  description = "(Required) Indicates which password clients should use, primary or secondary."
  type        = string
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