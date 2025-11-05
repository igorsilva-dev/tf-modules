resource "civo_firewall" "firewall" {
    name = var.firewall_name
    create_default_rules = var.create_default_rules
    network_id = civo_network.network.id
}

resource "civo_network" "network" {
  label = var.network_label
}