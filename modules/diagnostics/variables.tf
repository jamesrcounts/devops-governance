variable "log_analytics_workspace_id" {
  type        = string
  description = "(Required) Specifies the ID of a Log Analytics Workspace where Diagnostics Data should be sent."
}

variable "monitored_services" {
  type        = map(string)
  description = "(Required) A map of service names to thier resource ids that should be configured to send diagnostics to log analytics."
}