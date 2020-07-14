provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = "root"
  version = "= 2.11.0"
}

provider "consul" {
  version = "= 2.8.0"
  address = "http://127.0.0.1:8500"
}
