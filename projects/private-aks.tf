module "private_aks" {
  source = "./private-aks"

  github_pat = var.github_pat
  project    = "private-aks"
  repository = "jamesrcounts/private-aks"
}