variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace where the application runs"
  type        = string
}

variable "create_namespace" {
  description = "Create the Kubernetes namespace if it doesn't exist"
  type        = bool
  default     = true
}

variable "service_account_name" {
  description = "Name of the Kubernetes service account"
  type        = string
}

variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "policy_name" {
  description = "Name of the IAM policy"
  type        = string
  default     = null
}

variable "policy_document" {
  description = "IAM policy document (JSON string)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to IAM resources"
  type        = map(string)
  default     = {}
}
