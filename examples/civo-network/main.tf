module "network" {
  source = "../../civo/network"

  network_label        = var.network_label
  firewall_name        = var.firewall_name
  create_default_rules = var.create_default_rules
}
