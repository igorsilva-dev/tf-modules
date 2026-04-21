output "namespace_names" {
  description = "Map of namespace key to namespace name"
  value       = { for k, ns in kubernetes_namespace_v1.ns : k => ns.metadata[0].name }
}

output "service_account_names" {
  description = "Map of namespace key to service account name (empty if service accounts disabled)"
  value       = { for k, sa in kubernetes_service_account_v1.sa : k => sa.metadata[0].name }
}
