variable "cluster_name" {
  description = "Name of the Civo Kubernetes cluster"
  type        = string
  default     = "example-cluster"
}

variable "kubernetes_version" {
  description = "K3s version to deploy"
  type        = string
  default     = "1.32.5-k3s1"
}

variable "pools" {
  description = "List of node pools"
  type = list(object({
    label      = string
    size       = string
    node_count = number
  }))
  default = [
    {
      label      = "worker-pool"
      size       = "g4s.kube.xsmall"
      node_count = 1
    }
  ]
}
