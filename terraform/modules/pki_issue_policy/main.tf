resource "vault_pki_secret_backend_role" "cert_role" {
  backend = var.backend
  name = var.name
  ttl = var.ttl
  max_ttl = var.max_ttl
  allow_localhost = var.allow_localhost
  allowed_domains = var.allowed_domains
  allow_bare_domains = var.allow_bare_domains
  allow_subdomains = var.allow_subdomains
  key_type = var.key_type
  key_bits = var.key_bits
}


resource "vault_policy" "issue_cert_policy" {
  name = "${var.backend}-${var.name}-policy"
  policy = <<EOT
path "${var.backend}/issue/${vault_pki_secret_backend_role.cert_role.name}" {
  capabilities = [ "update" ]
}
EOT
}
