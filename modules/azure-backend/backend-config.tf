resource "local_file" "azurerm_backend_tfvars" {
  for_each = toset(var.backend_config_filename[*])

  filename = each.key
  content = templatefile(
    "${path.module}/templates/backend-config.tfvars.hcl",
    {
      container_name       = azurerm_storage_container.state.name
      key                  = local.blob_name
      resource_group_name  = azurerm_resource_group.state.name
      storage_account_name = azurerm_storage_account.state.name
    }
  )
}