resource "github_repository" "repository" {
  archive_on_destroy     = true
  delete_branch_on_merge = true
  has_downloads          = false
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  name                   = "tf-{local.namespace}"
  visibility             = "public"

  template {
    owner                = var.template_repository.owner
    repository           = var.template_repository.repository
    include_all_branches = true
  }
}
