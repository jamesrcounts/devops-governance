module "backend" {
  source = "../../modules/terraform-backend"

  project     = "azure-firewall-demo"
  admin_email = "jamesrcounts@outlook.com"
}