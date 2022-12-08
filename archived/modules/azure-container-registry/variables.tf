variable "resource_group_name" {
  description = "(Required) The name of the resource group for this project."
  type        = string
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "(Required) Specifies the ID of a Log Analytics Workspace where Diagnostics Data should be sent."
}