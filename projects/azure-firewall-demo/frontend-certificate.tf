resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = "jamesrcounts@outlook.com"
}

resource "acme_certificate" "certificate" {
  for_each = {
    prd = local.host_name
  }

  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = each.value
  subject_alternative_names = [each.value]

  dns_challenge {
    provider = "route53"
  }
}