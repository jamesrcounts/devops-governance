module "aks_istio" {
  source = "./aks-istio"

  // github_pat = var.github_pat
  project    = "aks-istio"
  repository = "jamesrcounts/aks-istio"
}