# resource "azurerm_key_vault_secret" "config" {
#   key_vault_id = var.config_key_vault_id
#   name         = "${local.tags["purpose"]}-instance-id"
#   value        = local.instance_id

#   tags = local.tags
# }