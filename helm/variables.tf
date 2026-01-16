variable "chart_name" {
  description = "Name of the Helm release"
  type        = string
}

variable "chart" {
  description = "Chart name to deploy"
  type        = string
}

variable "chart_repository" {
  description = "Helm chart repository URL"
  type        = string
}

variable "chart_version" {
  description = "Version of the Helm chart"
  type        = string
  default     = ""
}

variable "namespace" {
  description = "Kubernetes namespace to deploy the chart"
  type        = string
  default     = "default"
}

variable "create_namespace" {
  description = "Create the namespace if it does not exist"
  type        = bool
  default     = true
}

variable "values" {
  description = "List of values in raw YAML to pass to Helm"
  type        = list(string)
  default     = []
}

variable "set_values" {
  description = "Map of values to set (can include sensitive values)"
  type        = map(string)
  default     = {}
}

variable "wait" {
  description = "Wait for release to be deployed before returning"
  type        = bool
  default     = true
}

variable "timeout" {
  description = "Time in seconds to wait for release deployment"
  type        = number
  default     = 300
}
