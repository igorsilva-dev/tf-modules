locals {
  namespace_map = { for ns in var.namespaces : ns.name => ns }
}

resource "kubernetes_namespace_v1" "ns" {
  for_each = local.namespace_map

  metadata {
    name   = each.key
    labels = merge({ "managed-by" = "terraform" }, each.value.labels)
  }
}

resource "kubernetes_service_account_v1" "sa" {
  for_each = var.create_service_accounts ? local.namespace_map : {}

  metadata {
    name      = "${each.key}-sa"
    namespace = kubernetes_namespace_v1.ns[each.key].metadata[0].name
  }
}
