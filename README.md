# tf-modules

Collection of Terraform (OpenTofu-compatible) modules for provisioning infrastructure. This repo currently contains a Civo Kubernetes module.

## Purpose
Provide reusable, parameterized modules to create Civo Kubernetes clusters and related artifacts (kubeconfig file, outputs).

## Current modules
- civo/kubernetes — creates a Civo Kubernetes cluster and optionally writes kubeconfig to disk.

## Quick usage example
Call the module from your root configuration:

```hcl
module "k8s" {
  source = "./civo/kubernetes"

  cluster_name       = "my-cluster"
  network_id         = "net-xxxx"        # (check variable name in module: network_id / metwork_id)
  firewall_id        = "fw-xxxx"
  kubernetes_version = "1.28.0"
  write_kubeconfig   = true

  pools = [
    { label = "shop",  size = "g4s.kube.xsmall", node_count = 1 },
    { label = "batch", size = "g4s.kube.small",   node_count = 2 },
  ]
}