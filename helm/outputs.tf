output "release_name" {
  description = "Name of the Helm release"
  value       = helm_release.chart.name
}

output "release_namespace" {
  description = "Namespace where the Helm release was deployed"
  value       = helm_release.chart.namespace
}

output "release_version" {
  description = "Version of the deployed Helm chart"
  value       = helm_release.chart.version
}

output "release_status" {
  description = "Status of the Helm release"
  value       = helm_release.chart.status
}

output "release_manifest" {
  description = "Manifest of the deployed Helm release"
  value       = helm_release.chart.manifest
  sensitive   = true
}
