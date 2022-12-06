output "full_name" {
  description = "The repository full name."
  value       = github_repository.repository.full_name
}