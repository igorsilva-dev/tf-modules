resource "civo_network" "network" {
  label = var.network_label
}

resource "civo_firewall" "firewall" {
  name                 = var.firewall_name
  create_default_rules = var.create_default_rules
  network_id           = civo_network.network.id
}

resource "civo_dns_domain_name" "domain" {
  count = var.dns_domain != "" ? 1 : 0
  name  = var.dns_domain
}

resource "civo_dns_domain_record" "records" {
  for_each = var.dns_domain != "" ? { for r in var.dns_records : r.name => r } : {}

  domain_id = civo_dns_domain_name.domain[0].id
  type      = each.value.type
  name      = each.value.name
  value     = each.value.value
  ttl       = each.value.ttl
}