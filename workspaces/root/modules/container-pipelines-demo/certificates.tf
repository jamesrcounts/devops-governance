resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg_prd" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = "jamesrcounts@outlook.com"
}

resource "acme_certificate" "certificate_prd" {
  for_each = {
    dev = "dev.jamesrcounts.com"
    prd = "prd.jamesrcounts.com"
  }

  account_key_pem           = acme_registration.reg_prd.account_key_pem
  common_name               = each.value
  subject_alternative_names = [each.value]

  dns_challenge {
    provider = "route53"
  }
}

resource "azurerm_key_vault_certificate" "certificate" {
  for_each = acme_certificate.certificate_prd

  name         = replace(each.value.common_name, ".", "-")
  key_vault_id = azurerm_key_vault.config.id

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
  for_each = acme_certificate.certificate_prd

  name         = "${replace(each.value.common_name, ".", "-")}-cert"
  key_vault_id = azurerm_key_vault.config.id
  value        = "${each.value.certificate_pem}${each.value.issuer_pem}"
}

resource "azurerm_key_vault_secret" "ca" {
  for_each = acme_certificate.certificate_prd

  name         = "${replace(each.value.common_name, ".", "-")}-ca"
  key_vault_id = azurerm_key_vault.config.id
  value        = each.value.issuer_pem
}

resource "azurerm_key_vault_secret" "key" {
  for_each = acme_certificate.certificate_prd

  name         = "${replace(each.value.common_name, ".", "-")}-key"
  key_vault_id = azurerm_key_vault.config.id
  value        = each.value.private_key_pem
}