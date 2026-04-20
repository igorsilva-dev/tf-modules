# Civo Kubernetes Cluster Module

Provisions a K3s-based Kubernetes cluster on [Civo](https://www.civo.com/) with configurable node pools.

## Usage

```hcl
module "kubernetes" {
  source = "git::https://github.com/igorsilva-dev/tf-modules.git//civo/kubernetes?ref=v0.1.0"

  cluster_name       = "my-cluster"
  kubernetes_version = "1.32.5-k3s1"
  network_id         = module.network.network_id
  firewall_id        = module.network.firewall_id

  pools = [
    {
      label      = "worker-pool"
      size       = "g4s.kube.xsmall"
      node_count = 2
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `cluster_name` | Name of the Civo Kubernetes cluster | `string` | — | yes |
| `kubernetes_version` | K3s version to deploy (e.g. `1.32.5-k3s1`) | `string` | — | yes |
| `network_id` | ID of the Civo network (from `civo/network` module) | `string` | — | yes |
| `firewall_id` | ID of the Civo firewall (from `civo/network` module) | `string` | — | yes |
| `pools` | List of node pools (label, size, node_count) | `list(object)` | 1x `g4s.kube.xsmall` | no |
| `applications` | Comma-separated Civo marketplace apps to install | `string` | `""` | no |
| `write_kubeconfig` | Write kubeconfig to `/tmp/<cluster>-kubeconfig` | `bool` | `false` | no |

## Outputs

| Name | Description | Sensitive |
|------|-------------|-----------|
| `cluster_name` | Name of the created cluster | no |
| `kubeconfig` | Kubeconfig content for cluster access | yes |

## Notes

- The Civo provider must be configured with a valid API token and region in the calling module.
- Use `civo k8s versions` (CLI) or the Civo API to list available K3s versions.
- Node sizes can be listed with `civo size list`.
