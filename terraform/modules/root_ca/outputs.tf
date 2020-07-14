output "backend_path" {
  depends_on  = [pki_secret_backend_root_cert.root]
  value       = vault_mount.pki.path
  description = "Secret path in vault"
}
