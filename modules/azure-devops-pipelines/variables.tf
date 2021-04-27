variable "branch_name" {
  default     = "main"
  description = "(Optional) The branch name for which builds are triggered. Defaults to main."
  type        = string
}

variable "project" {
  description = "(Required) Specifies the Azure DevOps project name."
  type        = string
}

variable "repository" {
  description = "(Required) The repository id."
  type        = string
}

variable "service_principal" {
  description = "(Required) An Azure service principal.  Used to configure a an AzureRM service connection in Azure DevOps."
  sensitive   = true
  type = object({
    client_id         = string
    client_secret     = string
    subscription_id   = string
    subscription_name = string
    tenant_id         = string
  })
}

variable "yml_path" {
  default     = "azure-pipelines.yml"
  description = "(Optional) The path of the Yaml file describing the build definition. Defaults to azure-pipelines.yml"
  type        = string
}