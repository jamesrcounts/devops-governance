module "terraform_root" {
  source = "./root"

  application_administrator_script_name = var.application_administrator_script_name
  azuredevops_pat                       = var.azuredevops_pat
  azuredevops_url                       = var.azuredevops_url
  backend_config_filename               = var.backend_config_filename
  github_pat                            = var.github_pat
}