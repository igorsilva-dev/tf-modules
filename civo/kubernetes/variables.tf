variable "cluster_name" {
    description = "value for the name of the Kubernetes cluster"
  type = string
}

variable "kubernetes_version" {
    description = "value for the Kubernetes version"
  type = string  
}

variable "pools" {
  description = "List of node pool objects"
  type = list(object({
    label      = string
    size       = string
    node_count = number
  }))
  default = [
    {
      label      = "shop"
      size       = "g4s.kube.xsmall"
      node_count = 1
    }
  ]
}

variable "applications" {
    description = "value for the applications to be installed on the cluster"
  type = string
}

variable "write_kubeconfig" {
description = "Whether to write the kubeconfig to a local file"
  type = bool
  default = false
}

variable "network_id" {
  description = "value for the network ID"
  type = string
}

variable "firewall_id" {
  description = "value for the firewall ID"
  type = string
}