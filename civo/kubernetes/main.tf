resource "civo_kubernetes_cluster" "cluster" {
    name = var.cluster_name
    write_kubeconfig = var.write_kubeconfig
    network_id = var.network_id
    firewall_id = var.firewall_id
    kubernetes_version = var.kubernetes_version
    applications = var.applications
    dynamic "pools" {
      for_each = var.pools
      content {
        label      = pools.value.label
        size       = pools.value.size
        node_count = pools.value.node_count
      }
    }
}

resource "local_file" "kubeconfig" {
count    = var.write_kubeconfig ? 1 : 0
  filename = "/temp/${civo_kubernetes_cluster.cluster.name}-kubeconfig"  # Define the path and file name
  content  = civo_kubernetes_cluster.cluster.kubeconfig
}