module "diagnostics" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/diagnostics?ref=container-pipelines"

  log_analytics_workspace_id = var.log_analytics_workspace_id

  monitored_services = {
    acr = azurerm_container_registry.basic.id
  }
}