module "container_pipelines" {
  source = "./container-pipelines"

  aad_script_name = var.container_pipelines_aad_script_name
  github_pat      = var.github_pat
  project         = "container-pipelines"
  repository      = "jamesrcounts/phippyandfriends"

  aws = {
    id  = var.aws_access_key_id
    key = var.aws_secret_access_key
  }
}