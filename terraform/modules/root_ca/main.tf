resource "vault_mount" "pki" {
  path                  = var.path
  type                  = "pki"
  max_lease_ttl_seconds = 1676800000 # 10 years
}

resource "vault_pki_secret_backend_root_cert" "root" {
  backend     = vault_mount.pki.path
  type        = "internal"
  common_name = var.root_ca_common_name
  key_bits    = var.pki_ca_key_bits
  ttl         =  "43800h"
}

resource "vault_pki_secret_backend_config_urls" "config_urls" {
  backend                 = vault_mount.pki.path
  issuing_certificates    = ["${var.vault_root_url}/v1/${vault_mount.pki.path}/ca"]
  crl_distribution_points = ["${var.vault_root_url}/v1/${vault_mount.pki.path}/crl"]
}
