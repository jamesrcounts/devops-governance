locals {
  monitored_services = {
    kv = azurerm_key_vault.backend.id
    la = azurerm_log_analytics_workspace.diagnostics.id
  }
}

data "azurerm_monitor_diagnostic_categories" "categories" {
  for_each = local.monitored_services

  resource_id = each.value
}

resource "azurerm_monitor_diagnostic_setting" "setting" {
  for_each = local.monitored_services

  name                           = "diag-${each.key}"
  target_resource_id             = each.value
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.diagnostics.id
  log_analytics_destination_type = each.key == "apim" ? "Dedicated" : null

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.categories[each.key].logs

    content {
      category = log.value
      enabled  = true

      retention_policy {
        days    = 0
        enabled = false
      }
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.categories[each.key].metrics

    content {
      category = metric.value
      enabled  = true

      retention_policy {
        days    = 0
        enabled = false
      }
    }
  }
}