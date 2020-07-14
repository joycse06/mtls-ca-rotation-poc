variable "backend" {}
variable "name" {}
variable "ttl" {
  default = ""
}
variable "max_ttl" {
  default = ""
}
variable "allow_localhost" {
  default = true
}
variable "allowed_domains" {
  type = list
}
variable "allow_bare_domains" {
  default = false
}
variable "allow_subdomains" {
  default = true
}
variable "key_type" {
  default = "rsa"
}
variable "key_bits" {
  default = 2048
}
