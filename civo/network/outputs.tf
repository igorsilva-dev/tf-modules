output "firewall_id" {
  description = "ID of the created Civo firewall"
  value       = civo_firewall.firewall.id
}

output "firewall_name" {
  description = "Name of the created Civo firewall"
  value       = civo_firewall.firewall.name
}

output "network_id" {
  description = "ID of the created Civo network"
  value       = civo_network.network.id
}

output "network_label" {
  description = "Label of the created Civo network"
  value       = civo_network.network.label
}
