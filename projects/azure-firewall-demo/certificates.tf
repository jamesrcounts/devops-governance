resource "azurerm_key_vault_certificate" "certificate" {
  for_each = acme_certificate.certificate

  name         = replace(each.value.common_name, ".", "-")
  key_vault_id = module.azure_backend.key_vault.id

  certificate {
    contents = each.value.certificate_p12
    password = ""
  }

  certificate_policy {
    issuer_parameters {
      name = "Unknown"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = false
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }
  }
}

resource "azurerm_key_vault_secret" "certificate" {
  for_each = acme_certificate.certificate

  name         = "${replace(each.value.common_name, ".", "-")}-cert"
  key_vault_id = module.azure_backend.key_vault.id
  value        = "${each.value.certificate_pem}${each.value.issuer_pem}"
}

resource "azurerm_key_vault_certificate" "ca_certificate" {
  name         = "CACert"
  key_vault_id = module.azure_backend.key_vault.id

  certificate {
    contents = pkcs12_from_pem.inter_pkcs12.result
    password = ""
  }
}

resource "azurerm_key_vault_certificate" "rootca_certificate" {
  name         = "RootCA"
  key_vault_id = module.azure_backend.key_vault.id

  certificate {
    contents = pkcs12_from_pem.root_pkcs12.result
    password = ""
  }
}

resource "azurerm_key_vault_secret" "ca" {
  for_each = acme_certificate.certificate

  name         = "${replace(each.value.common_name, ".", "-")}-ca"
  key_vault_id = module.azure_backend.key_vault.id
  value        = each.value.issuer_pem
}

resource "azurerm_key_vault_secret" "key" {
  for_each = acme_certificate.certificate

  name         = "${replace(each.value.common_name, ".", "-")}-key"
  key_vault_id = module.azure_backend.key_vault.id
  value        = each.value.private_key_pem
}