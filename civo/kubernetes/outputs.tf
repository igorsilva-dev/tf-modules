output "cluster_name" {
  description = "Name of the created Civo Kubernetes cluster"
  value       = civo_kubernetes_cluster.cluster.name
}

output "kubeconfig" {
  description = "Kubeconfig content for the created Civo Kubernetes cluster"
  value       = civo_kubernetes_cluster.cluster.kubeconfig
  sensitive   = true  
}