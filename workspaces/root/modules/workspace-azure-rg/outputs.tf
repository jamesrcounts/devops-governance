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