module "terraform_pipelines" {
  source = "./terraform-pipelines"

  providers = {
    azurerm     = azurerm
    azurerm.env = azurerm.env
  }

  github_pat = var.github_pat
  project    = "terraform-pipelines"
  repository = "jamesrcounts/terraform-getting-started-azure"
}
