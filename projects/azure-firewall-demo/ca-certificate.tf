locals {
  host_name = "firewall.jamesrcounts.com"
}

resource "tls_private_key" "root_ca" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "tls_self_signed_cert" "root_ca" {
  key_algorithm         = tls_private_key.root_ca.algorithm
  dns_names             = [local.host_name]
  private_key_pem       = tls_private_key.root_ca.private_key_pem
  validity_period_hours = 24

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]

  subject {
    common_name  = local.host_name
    organization = "Contoso Inc."
  }
}

resource "tls_private_key" "intermediate_ca" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "tls_cert_request" "intermediate_ca" {
  key_algorithm   = tls_private_key.intermediate_ca.algorithm
  private_key_pem = tls_private_key.intermediate_ca.private_key_pem
  uris            = [local.host_name]

  subject {
    common_name  = local.host_name
    organization = "Contoso Inc."
  }
}

resource "tls_locally_signed_cert" "intermediate_ca" {
  cert_request_pem   = tls_cert_request.intermediate_ca.cert_request_pem
  ca_key_algorithm   = tls_private_key.root_ca.algorithm
  ca_private_key_pem = tls_private_key.root_ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.root_ca.cert_pem

  validity_period_hours = 24
  is_ca_certificate     = true
  allowed_uses = [
    "cert_signing",
    "key_encipherment",
    "digital_signature",
  ]
}

resource "pkcs12_from_pem" "inter_pkcs12" {
  password        = ""
  cert_pem        = tls_locally_signed_cert.intermediate_ca.cert_pem
  private_key_pem = tls_private_key.intermediate_ca.private_key_pem
}