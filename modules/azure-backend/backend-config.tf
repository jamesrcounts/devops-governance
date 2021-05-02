resource "local_file" "azurerm_backend_tfvars" {
  filename = "azurerm.backend.tfvars"
  content = <<EOF
container_name       = "state"
key                  = "terraform.tfstate"
resource_group_name  = "rg-backend-nice-chimp"
storage_account_name = "sanicechimp"
EOF
}