# Helm Release Example

Deploys an nginx instance using the Bitnami Helm chart via the `helm` module.

## Prerequisites

- [OpenTofu](https://opentofu.org/) installed (`tofu` CLI)
- A running Kubernetes cluster
- `kubeconfig` configured (default: `~/.kube/config`)

## Usage

```bash
tofu init
tofu plan
tofu apply
```

## Customisation

Edit `variables.tf` or pass overrides:

```bash
tofu apply -var="namespace=my-nginx" -var="chart_version=18.1.0"
```

## Clean up

```bash
tofu destroy
```
