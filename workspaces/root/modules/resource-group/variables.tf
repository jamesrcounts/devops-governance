variable "namespace" {
  description = "The resource group namespace."
  type        = string
}

variable "repository" {
  description = "The repository details."
  type = object({
    name                = string
    workspace_directory = string
  })
}