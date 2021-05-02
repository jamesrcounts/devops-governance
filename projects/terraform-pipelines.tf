module "terraform_pipelines" {
  source = "./terraform-pipelines"

  # azuredevops_pat         = var.azuredevops_pat
  # azuredevops_url         = var.azuredevops_url
  # backend_config_filename = var.backend_config_filename
  # github_pat              = var.github_pat
  project    = "terraform-pipelines"
  repository = "jamesrcounts/terraform-getting-started-azure"
}