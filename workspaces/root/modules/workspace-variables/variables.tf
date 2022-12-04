variable "variables" {
  description = "The variable sets to associate with the workspace."
  type = map(object({
    id = string
  }))
}

variable "workspace_id" {
  description = "The workspace to associate with variables."
  type        = string
}