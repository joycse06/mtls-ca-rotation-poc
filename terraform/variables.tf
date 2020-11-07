variable "path" {
  description = "The unique path where the PKI engine will be mounted in vault."
}
variable "root_ca_common_name" {
  description = "Root CA common name, useful to identify which CA issued a certificate."
}
variable "root_ca_cn_prefix" {
  default     = "PKI"
  description = "A prefix to put in front of Root CA common names so they are namespaced."
}
variable "vault_root_url" {
  description = "The vault root url (Used to construct the issuer and crl url to put into certificate attributes)."
}

