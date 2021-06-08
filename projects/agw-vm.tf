module "agw_vm" {
  source = "./agw-vm"

  github_pat = var.github_pat
  project    = "agw-vm"
  repository = "jamesrcounts/agw-vm"
}