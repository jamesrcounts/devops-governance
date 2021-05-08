module "container_pipelines" {
  source = "./container-pipelines"

  github_pat = var.github_pat
  project    = "container-pipelines"
  repository = "jamesrcounts/phippyandfriends"
}