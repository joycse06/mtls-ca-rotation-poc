module "root" {
  source           = "./../root_ca"
  path             = "${var.path}"
  root_ca_common_name = "PKI: ${var.common_name}"
  vault_root_url   = "${var.vault_root_url}"
}

module "root_a_issuer_role" {
  source          = "./../pki_issue_policy"
  backend         = "${module.root.backend_path}"
  allowed_domains = ["pki.example.com"]
  name            = "${var.issuer_role_name}"
}
