# Kubernetes Namespaces & RBAC Module

Creates Kubernetes namespaces with optional service accounts and a read-only ClusterRole for platform observability.

## Usage

```hcl
module "namespaces" {
  source = "git::https://github.com/igorsilva-dev/tf-modules.git//kubernetes/namespaces-rbac?ref=v0.1.0"

  namespaces = [
    {
      name   = "platform"
      labels = { "team" = "platform", "tier" = "infra" }
    },
    {
      name   = "agents"
      labels = { "team" = "ai", "tier" = "workloads" }
    },
    {
      name   = "sandbox"
      labels = { "team" = "dev", "tier" = "experiments" }
    }
  ]
}
```

### Without service accounts or RBAC

```hcl
module "namespaces" {
  source = "git::https://github.com/igorsilva-dev/tf-modules.git//kubernetes/namespaces-rbac?ref=v0.1.0"

  namespaces = [
    { name = "staging" },
    { name = "production" }
  ]

  create_service_accounts = false
  create_read_only_role   = false
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `namespaces` | List of namespaces (name + optional labels) | `list(object)` | — | yes |
| `create_service_accounts` | Create a service account in each namespace | `bool` | `true` | no |
| `create_read_only_role` | Create a cluster-wide read-only role bound to namespace SAs | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| `namespace_names` | Map of namespace key to namespace name |
| `service_account_names` | Map of namespace key to service account name |

## What the read-only ClusterRole covers

When `create_read_only_role = true`, a `platform-read-only` ClusterRole is created with `get`, `list`, `watch` permissions on:

- Core: pods, services, configmaps, events, namespaces, nodes
- Apps: deployments, replicasets, statefulsets, daemonsets
- Batch: jobs, cronjobs
- Networking: ingresses, networkpolicies

Each namespace's service account gets a ClusterRoleBinding to this role.

## Notes

- The Kubernetes provider must be configured in the calling module (kubeconfig or in-cluster config).
- All resources are labelled with `managed-by: terraform` for easy identification.
- Service account names follow the pattern `<namespace-name>-sa`.
