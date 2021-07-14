module "terraform_root" {
  source = "./root"

  aws              = local.aws
  azuredevops_pat  = var.azuredevops_pat
  azuredevops_url  = var.azuredevops_url
  generate_scripts = var.generate_scripts
  github_pat       = var.github_pat
}