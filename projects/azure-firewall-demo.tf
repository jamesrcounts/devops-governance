module "azure_firewall_demo" {
  source = "./azure-firewall-demo"

  repository = "jamesrcounts/azure-firewall-demo"
  github_pat = var.github_pat

}