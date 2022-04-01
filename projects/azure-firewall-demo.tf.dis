module "azure_firewall_demo" {
  source = "./azure-firewall-demo"

  providers = {
    azurerm     = azurerm
    azurerm.env = azurerm.env
  }

  repository = "jamesrcounts/azure-firewall-demo"
  github_pat = var.github_pat

}