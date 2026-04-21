# Kubernetes Namespaces & RBAC Example

Creates three namespaces (`platform`, `agents`, `sandbox`) with service accounts and a read-only ClusterRole using the `kubernetes/namespaces-rbac` module.

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

## Clean up

```bash
terraform destroy
```
