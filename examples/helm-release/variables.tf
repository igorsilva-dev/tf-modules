variable "chart_name" {
  description = "Name of the Helm release"
  type        = string
  default     = "nginx"
}

variable "chart_version" {
  description = "Version of the nginx Helm chart"
  type        = string
  default     = "18.1.0"
}

variable "namespace" {
  description = "Kubernetes namespace to deploy into"
  type        = string
  default     = "nginx"
}

variable "kubeconfig_path" {
  description = "Path to kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}
