## Org level
resource "tfe_organization" "org" {
  email = "jamesrcounts@outlook.com"
  name  = "olive-mercury"
}

resource "tfe_oauth_client" "github" {
  organization     = tfe_organization.org.name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_pat
  service_provider = "github"
}

resource "tfe_variable_set" "credentials" {
  for_each = toset(["github", "tfe"])

  description  = "${each.key} credentials"
  name         = each.key
  organization = tfe_organization.org.name
}

resource "tfe_variable" "credentials" {
  for_each = {
    github = {
      name        = "github_pat"
      value       = var.github_pat
      description = "GitHub Personal Access Token"
    }
    tfe = {
      name        = "tfe_token"
      value       = var.tfe_token
      description = "Terraform Cloud API Token"
    }
  }

  category        = "terraform"
  description     = each.value.description
  key             = each.value.name
  sensitive       = true
  value           = each.value.value
  variable_set_id = tfe_variable_set.credentials[each.key].id
}



## Workspace

resource "tfe_workspace" "root" {
  description       = "Use the root worksapce to create additional workspaces."
  name              = "root"
  organization      = tfe_organization.org.name
  tag_names         = ["workspaces", "root"]
  terraform_version = "~> 1.3.6"
  working_directory = "workspaces/root"

  vcs_repo {
    identifier     = "jamesrcounts/devops-governance"
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "github" {
  for_each = tfe_variable_set.credentials

  variable_set_id = each.value.id
  workspace_id    = tfe_workspace.root.id
}