# Helm Release Example

Deploys an nginx instance using the Bitnami Helm chart via the `helm` module.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) or [OpenTofu](https://opentofu.org/) installed
- A running Kubernetes cluster
- `kubeconfig` configured (default: `~/.kube/config`)

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## Customisation

Edit `variables.tf` or pass overrides:

```bash
terraform apply -var="namespace=my-nginx" -var="chart_version=18.1.0"
```

## Clean up

```bash
terraform destroy
```
