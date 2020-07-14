variable "path" {
}
variable "root_ca_common_name" {
}

variable "vault_root_url" {
}
variable "pki_ca_key_bits" {
  default = 2048
}
variable "root_cert_ttl" {
  default = "43800h" # 5 years
}
