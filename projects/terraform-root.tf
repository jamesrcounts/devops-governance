module "terraform_root" {
  source = "./root"

  azuredevops_pat         = var.azuredevops_pat
  azuredevops_url         = var.azuredevops_url
  backend_config_filename = var.backend_config_filename
  github_pat              = var.github_pat
}