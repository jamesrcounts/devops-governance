module "terraform_pipelines" {
  source = "./terraform-pipelines"

  providers = {
    azurerm      = azurerm
    azurerm.apps = azurerm.apps
  }

  github_pat = var.github_pat
  project    = "terraform-pipelines"
  repository = "jamesrcounts/terraform-getting-started-azure"
}
