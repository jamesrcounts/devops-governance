resource "azurerm_storage_account" "state" {
  account_kind              = "StorageV2"
  account_replication_type  = "RAGZRS"
  account_tier              = "Premium"
  allow_blob_public_access  = false
  enable_https_traffic_only = true
  location                  = azurerm_resource_group.state.location
  min_tls_version           = "TLS1_2"
  name                      = replace("sa-${local.project_id}", "-", "")
  resource_group_name       = azurerm_resource_group.state.name
  tags                      = local.tags

  blob_properties {
    delete_retention_policy {
      days = 30
    }
    container_delete_retention_policy {
      days = 30
    }
  }

  identity {
    type = "SystemAssigned"
  }
}

