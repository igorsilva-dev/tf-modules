output "network_id" {
  description = "ID of the created network"
  value       = module.network.network_id
}

output "firewall_id" {
  description = "ID of the created firewall"
  value       = module.network.firewall_id
}
