output "network_id" {
  description = "ID of the created Civo network"
  value       = civo_network.network.id
}

output "network_label" {
  description = "Label of the created Civo network"
  value       = civo_network.network.label
}

output "firewall_id" {
  description = "ID of the created Civo firewall"
  value       = civo_firewall.firewall.id
}

output "firewall_name" {
  description = "Name of the created Civo firewall"
  value       = civo_firewall.firewall.name
}

output "dns_domain_id" {
  description = "ID of the created DNS domain (empty if DNS not configured)"
  value       = var.dns_domain != "" ? civo_dns_domain_name.domain[0].id : ""
}

output "dns_domain_name" {
  description = "Name of the created DNS domain (empty if DNS not configured)"
  value       = var.dns_domain != "" ? civo_dns_domain_name.domain[0].name : ""
}
