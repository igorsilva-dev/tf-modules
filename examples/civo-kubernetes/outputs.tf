output "cluster_name" {
  description = "Name of the created cluster"
  value       = module.kubernetes.cluster_name
}

output "kubeconfig" {
  description = "Kubeconfig for cluster access"
  value       = module.kubernetes.kubeconfig
  sensitive   = true
}
