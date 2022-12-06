resource "github_repository" "repository" {
  archive_on_destroy     = true
  delete_branch_on_merge = true
  has_downloads          = false
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  name                   = var.name
  visibility             = "public"

  template {
    owner      = var.template.owner
    repository = var.template.repository
  }
}