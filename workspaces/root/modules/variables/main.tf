resource "tfe_variable_set" "vs" {
  description  = var.description
  name         = var.name
  organization = var.organization_name
}

resource "tfe_variable" "variable" {
  for_each = nonsensitive(var.variables)

  category        = "terraform"
  description     = each.value.description
  key             = each.key
  sensitive       = each.value.sensitive
  value           = each.value.value
  variable_set_id = tfe_variable_set.vs.id
}