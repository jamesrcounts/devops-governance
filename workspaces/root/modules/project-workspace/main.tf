# resource "tfe_workspace" "ws" {
#   name              = "root"
#   organization      = tfe_organization.org.name
#   tag_names         = ["workspaces", "root"]
#   terraform_version = "~> 1.3.6"
#   working_directory = "workspaces/root"
#   # execution_mode    = "local"

#   vcs_repo {
#     identifier     = "jamesrcounts/devops-governance"
#     oauth_token_id = tfe_oauth_client.github.oauth_token_id
#   }
# }

locals {
  namespace = random_pet.instance_id.id
}

resource "random_pet" "instance_id" {}

resource "github_repository" "repository" {
  archive_on_destroy     = true
  delete_branch_on_merge = true
  has_downloads          = false
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  name                   = "tf-gs-${local.namespace}"
  visibility             = "public"

  security_and_analysis {
    advanced_security {
      status = "enabled"
    }
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }

  template {
    owner                = "jamesrcounts"
    repository           = "terraform-getting-started-azure"
    include_all_branches = true
  }
}