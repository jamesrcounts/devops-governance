locals {
  name      = "tf-gs-${local.namespace}"
  namespace = random_pet.instance_id.id
}

resource "random_pet" "instance_id" {}

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

resource "tfe_workspace" "ws" {
  name              = local.name
  organization      = var.organization_name
  tag_names         = ["terraform", "pipelines"]
  terraform_version = "~> 1.3.6"
  working_directory = "/infrastructure"

  vcs_repo {
    identifier     = github_repository.repository.full_name
    oauth_token_id = var.oauth_token_id
  }
}
