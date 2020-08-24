module "pki_root_a" {
  source         = "./modules/pki_root"
  path           = "pki/root-a"
  common_name    = "Root A"
  vault_root_url = "${var.vault_root_url}"
  issuer_role_name    = "issuer"
}

module "pki_root_b" {
  source         = "./modules/pki_root"
  path           = "pki/root-b"
  common_name    = "Root B"
  vault_root_url = "${var.vault_root_url}"
  issuer_role_name    = "issuer"
}

# Consul Key

resource "consul_keys" "root" {
  key {
    path = "pki/root"
    value = <<-EOT
    {
      "primary_issuer": "${module.pki_root_a.backend_path}",
      "secondary_issuers": [${module.pki_root_b.backend_path}]
    }
    EOT
  }
}
