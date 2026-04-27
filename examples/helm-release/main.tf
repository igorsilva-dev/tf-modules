module "nginx" {
  source = "../../helm"

  chart_name       = var.chart_name
  chart            = "nginx"
  chart_repository = "https://charts.bitnami.com/bitnami"
  chart_version    = var.chart_version
  namespace        = var.namespace
  create_namespace = true

  set_values = {
    "replicaCount"              = "2"
    "service.type"              = "ClusterIP"
    "resources.requests.memory" = "128Mi"
    "resources.requests.cpu"    = "100m"
  }
}
