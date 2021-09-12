module "container_pipelines" {
  source = "./container-pipelines"

  providers = {
    azurerm     = azurerm
    azurerm.bo  = azurerm
    azurerm.env = azurerm.env
  }

  aws        = local.aws
  github_pat = var.github_pat
  project    = "container-pipelines"
  repository = "jamesrcounts/phippyandfriends"
}