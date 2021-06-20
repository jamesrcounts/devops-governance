resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = "jamesrcounts@outlook.com"
}

resource "acme_certificate" "certificate" {
  for_each = {
    api    = "api.jamesrcounts.com"
    portal = "portal.jamesrcounts.com"
  }

  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = each.value
  subject_alternative_names = [each.value]

  dns_challenge {
    provider = "route53"
  }
}

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