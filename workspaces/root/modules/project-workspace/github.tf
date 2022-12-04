resource "github_repository" "repository" {
  archive_on_destroy     = false
  delete_branch_on_merge = true
  has_downloads          = false
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  name                   = local.name
  visibility             = "public"

  template {
    owner                = "jamesrcounts"
    repository           = "terraform-getting-started-azure"
    include_all_branches = true
  }
}
