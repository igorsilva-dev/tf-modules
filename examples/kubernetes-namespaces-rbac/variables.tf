variable "kubeconfig_path" {
  description = "Path to kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "create_service_accounts" {
  description = "Create a service account in each namespace"
  type        = bool
  default     = true
}

variable "create_read_only_role" {
  description = "Create a cluster-wide read-only role"
  type        = bool
  default     = true
}
