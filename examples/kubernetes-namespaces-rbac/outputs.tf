output "namespace_names" {
  description = "Created namespace names"
  value       = module.namespaces.namespace_names
}

output "service_account_names" {
  description = "Created service account names"
  value       = module.namespaces.service_account_names
}
