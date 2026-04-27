output "release_name" {
  description = "Name of the Helm release"
  value       = module.nginx.release_name
}

output "release_namespace" {
  description = "Namespace of the Helm release"
  value       = module.nginx.release_namespace
}

output "release_version" {
  description = "Version of the deployed chart"
  value       = module.nginx.release_version
}

output "release_status" {
  description = "Status of the Helm release"
  value       = module.nginx.release_status
}
