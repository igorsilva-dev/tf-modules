resource "helm_release" "chart" {
  name             = var.chart_name
  repository       = var.chart_repository
  chart            = var.chart
  namespace        = var.namespace
  version          = var.chart_version
  create_namespace = var.create_namespace
  values           = var.values
  wait             = var.wait
  timeout          = var.timeout

  dynamic "set" {
    for_each = var.set_values
    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.set_sensitive_values
    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }
}
