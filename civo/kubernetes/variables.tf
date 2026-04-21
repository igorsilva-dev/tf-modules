variable "cluster_name" {
  description = "Name of the Civo Kubernetes cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "K3s version to deploy (e.g. 1.32.5-k3s1). Use 'civo k8s versions' to list available versions"
  type        = string
}

variable "pools" {
  description = "List of node pools. Each pool requires a label (identifier), size (Civo instance type), and node_count"
  type = list(object({
    label      = string
    size       = string
    node_count = number
  }))
  default = [
    {
      label      = "default"
      size       = "g4s.kube.xsmall"
      node_count = 1
    }
  ]
}

variable "applications" {
  description = "Comma-separated list of Civo marketplace applications to install on the cluster"
  type        = string
  default     = ""
}

variable "write_kubeconfig" {
  description = "Whether to write the kubeconfig to a local file at /tmp/<cluster-name>-kubeconfig"
  type        = bool
  default     = false
}

variable "network_id" {
  description = "ID of the Civo network to attach the cluster to (from the civo/network module)"
  type        = string
}

variable "firewall_id" {
  description = "ID of the Civo firewall to apply to the cluster (from the civo/network module)"
  type        = string
}