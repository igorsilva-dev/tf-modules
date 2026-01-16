# Helm Chart Module

Generic Terraform module for deploying Helm charts to Kubernetes clusters.

## Features
- Deploy any Helm chart from public or private repositories
- Support for multiple values files
- Set individual values via `set_values` and `set_sensitive_values`
- Automatic namespace creation (optional)
- Configurable wait timeouts

## Usage

Basic example:
```hcl
module "nginx" {
  source = "./helm"

  chart_name       = "nginx-release"
  chart            = "nginx"
  chart_repository = "https://charts.bitnami.com/bitnami"
  namespace        = "ingress"
  chart_version    = "14.0.0"
}
```

With custom values:
```hcl
module "prometheus" {
  source = "./helm"

  chart_name       = "prometheus"
  chart            = "prometheus"
  chart_repository = "https://prometheus-community.github.io/helm-charts"
  namespace        = "monitoring"
  create_namespace = true

  set_values = {
    "prometheus.retention" = "15d"
    "prometheus.scrapeInterval" = "30s"
  }
}
```

With values file:
```hcl
module "grafana" {
  source = "./helm"

  chart_name       = "grafana"
  chart            = "grafana"
  chart_repository = "https://grafana.github.io/helm-charts"
  namespace        = "monitoring"

  values = [
    file("${path.module}/values.yaml")
  ]
}
```

With sensitive values:
```hcl
module "sealed-secrets" {
  source = "./helm"

  chart_name       = "sealed-secrets"
  chart            = "sealed-secrets"
  chart_repository = "https://sealed-secrets-charts.storage.googleapis.com"
  namespace        = "kube-system"

  set_sensitive_values = {
    "commandArgs[0]" = sensitive(var.secret_key)
  }
}
```

## Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `chart_name` | string | - | Name of the Helm release (required) |
| `chart` | string | - | Chart name to deploy (required) |
| `chart_repository` | string | - | Helm chart repository URL (required) |
| `chart_version` | string | "" | Version of the Helm chart |
| `namespace` | string | "default" | Kubernetes namespace to deploy the chart |
| `create_namespace` | bool | true | Create the namespace if it does not exist |
| `values` | list(string) | [] | List of values in raw YAML to pass to Helm |
| `set_values` | map(string) | null | Map of values to set via --set flag |
| `set_sensitive_values` | map(string) | null | Map of sensitive values (marked as sensitive in state) |
| `wait` | bool | true | Wait for release to be deployed before returning |
| `timeout` | number | 300 | Time in seconds to wait for release deployment |

## Outputs

| Name | Description |
|------|-------------|
| `release_name` | Name of the Helm release |
| `release_namespace` | Namespace where the Helm release was deployed |
| `release_version` | Version of the deployed Helm chart |
| `release_status` | Status of the Helm release |
| `release_manifest` | Manifest of the deployed Helm release (sensitive) |

## Requirements

- Terraform >= 1.0
- Helm provider >= 2.11
- Kubernetes cluster with Helm access configured
