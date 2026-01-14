variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "addons" {
  description = "List of EKS addons to deploy"
  type = list(object({
    name          = string
    addon_version = optional(string)
  }))
  default = []
}