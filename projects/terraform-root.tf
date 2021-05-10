module "terraform_root" {
  source = "./root"

  aad_script_name         = var.terraform_root_aad_script_name
  azuredevops_pat         = var.azuredevops_pat
  azuredevops_url         = var.azuredevops_url
  backend_config_filename = var.backend_config_filename
  github_pat              = var.github_pat
}