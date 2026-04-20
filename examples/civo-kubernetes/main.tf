module "network" {
  source = "../../civo/network"

  network_label        = "example-network"
  firewall_name        = "example-firewall"
  create_default_rules = true
}

module "kubernetes" {
  source = "../../civo/kubernetes"

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version
  network_id         = module.network.network_id
  firewall_id        = module.network.firewall_id
  write_kubeconfig   = true

  pools = var.pools
}
