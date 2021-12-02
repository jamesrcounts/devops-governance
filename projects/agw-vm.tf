module "agw_vm" {
  source = "./agw-vm"

  providers = {
    azurerm     = azurerm
    azurerm.env = azurerm.env
  }

  github_pat = var.github_pat
  project    = "agw-vm"
  repository = "jamesrcounts/agw-vm"
}