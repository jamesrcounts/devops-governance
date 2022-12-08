module "rg_ops" {
  source = "../resource-group"

  namespace = "ops-${module.workspace.namespace}"
  location  = local.location

  repository = {
    name                = module.workspace.repository_full_name
    workspace_directory = module.workspace.workspace_directory
  }
}

module "variable" {
  source   = "../variables"
  for_each = local.variable

  description       = each.value.description
  name              = "${replace(each.key, "_", "-")}-${module.workspace.namespace}"
  organization_name = var.organization_name
  variables         = each.value.variables
}

resource "tfe_workspace_variable_set" "workspace_variables" {
  for_each = module.variable

  variable_set_id = each.value.id
  workspace_id    = module.workspace.id
}

resource "tfe_workspace_variable_set" "shared_workspace_variables" {
  for_each = {
    aws = var.aws_credentials
  }

  variable_set_id = each.value
  workspace_id    = module.workspace.id
}

# OPS Resources
resource "azurerm_log_analytics_workspace" "diagnostics" {
  location            = local.location
  name                = "la-ops-${module.workspace.namespace}"
  resource_group_name = module.rg_ops.name
  retention_in_days   = 30
  sku                 = "PerGB2018"
  tags                = module.rg_ops.tags
}

resource "azurerm_key_vault" "config" {
  enable_rbac_authorization   = true
  enabled_for_disk_encryption = false
  location                    = local.location
  name                        = "kv-ops-${module.workspace.namespace}"
  purge_protection_enabled    = false
  resource_group_name         = module.rg_ops.name
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  tags                        = module.rg_ops.tags
  tenant_id                   = var.subscription.tenant_id
}
