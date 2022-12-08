module "root" {
  source = "./root"

  arm_env_subscription_id = var.arm_env_subscription_id
  aws                     = local.aws
  azuredevops_pat         = var.azuredevops_pat
  azuredevops_url         = var.azuredevops_url
  github_pat              = var.github_pat
  tfe_token               = var.tfe_token
}