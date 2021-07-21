module "container_pipelines" {
  source = "./container-pipelines"

  providers = {
    azurerm.bo  = azurerm
    azurerm.env = azurerm.env
    acme.stg    = acme.stg
    acme.prd    = acme
  }

  aws        = local.aws
  github_pat = var.github_pat
  project    = "container-pipelines"
  repository = "jamesrcounts/phippyandfriends"
}