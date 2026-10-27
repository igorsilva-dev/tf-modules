resource "civo_network" "network" {
  label = var.network_label
}

locals {
  # Passing either rule list switches off Civo's defaults, which open every port to 0.0.0.0/0.
  custom_rules = var.ingress_rules != null || var.egress_rules != null

  # Everything from the network itself (node to node: kubelet, flannel VXLAN, ...). Civo doesn't
  # document whether its firewall filters private traffic, so it is allowed explicitly.
  internal_rules = local.custom_rules && var.allow_internal_traffic ? [
    for protocol in ["tcp", "udp", "icmp"] : {
      label      = "internal-${protocol}"
      protocol   = protocol
      port_range = protocol == "icmp" ? null : "1-65535"
      cidr       = [civo_network.network.cidr_v4]
    }
  ] : []

  # Without explicit egress, a custom firewall would cut the cluster off from images, Git and secrets.
  default_egress = [
    for protocol in ["tcp", "udp", "icmp"] : {
      label      = "all-${protocol}"
      protocol   = protocol
      port_range = protocol == "icmp" ? null : "1-65535"
      cidr       = ["0.0.0.0/0"]
    }
  ]

  ingress = local.custom_rules ? concat(local.internal_rules, coalesce(var.ingress_rules, [])) : []
  egress  = local.custom_rules ? coalesce(var.egress_rules, local.default_egress) : []
}

resource "civo_firewall" "firewall" {
  name                 = var.firewall_name
  create_default_rules = local.custom_rules ? false : var.create_default_rules
  network_id           = civo_network.network.id

  dynamic "ingress_rule" {
    for_each = local.ingress
    content {
      label      = ingress_rule.value.label
      protocol   = ingress_rule.value.protocol
      port_range = ingress_rule.value.port_range
      cidr       = ingress_rule.value.cidr
      action     = "allow"
    }
  }

  dynamic "egress_rule" {
    for_each = local.egress
    content {
      label      = egress_rule.value.label
      protocol   = egress_rule.value.protocol
      port_range = egress_rule.value.port_range
      cidr       = egress_rule.value.cidr
      action     = "allow"
    }
  }
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