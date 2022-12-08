output "id" {
  description = "The Terraform cloud workspace ID."
  value       = tfe_workspace.ws.id
}
output "workspace_directory" {
  description = "The directory containing the workspace Terraform module."
  value       = var.workspace_directory
}

output "repository_full_name" {
  description = "The GitHub repository created for this workspace."
  value       = module.repository.full_name
}

output "namespace" {
  description = "The instance ID for this workspace."
  value       = local.namespace
}

output "variable_set" {
  description = "Root variable sets that can be reused by child workspaces."
  value       = { for k, v in module.variable : k => v.id if contains(["azure_env"], k) }
}