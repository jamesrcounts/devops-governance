module "terraform_root" {
  source = "./root"

  azuredevops_pat = var.azuredevops_pat
  azuredevops_url = var.azuredevops_url
  github_pat      = var.github_pat
}