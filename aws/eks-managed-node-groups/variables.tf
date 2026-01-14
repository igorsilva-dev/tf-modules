variable "common_tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "cluster_subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name to create MNG"
}

variable "kubernetes_version" {
  description = "Kubernetes version for the node group"
  type        = string
  default     = "1.34"
}

variable "node_groups" {
  description = "Map of node group configurations"
  type = map(object({
    node_group_name = string
    subnet_ids      = list(string)
    capacity_type   = string
    instance_types  = list(string)
    desired_size    = number
    max_size        = number
    min_size        = number
    tags            = optional(map(string), {})
  }))
}
