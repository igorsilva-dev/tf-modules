resource "helm_release" "chart" {
  name             = var.chart_name
  repository       = var.chart_repository
  chart            = var.chart
  namespace        = var.namespace
  version          = var.chart_version
  create_namespace = var.create_namespace
  values           = concat(var.values, [for k, v in var.set_values : "${k}=${v}"])
  wait             = var.wait
  timeout          = var.timeout
}
