variable "github_pat" {
  description = "(Required) A github personal access token to create the VCS connection."
  sensitive   = true
  type        = string
}