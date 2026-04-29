# Kubernetes Namespaces & RBAC Example

Creates three namespaces (`platform`, `agents`, `sandbox`) with service accounts and a read-only ClusterRole using the `kubernetes/namespaces-rbac` module.

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

## Clean up

```bash
tofu destroy
```
