variable "namespaces" {
  description = "List of namespaces to create. Each namespace has a name and optional labels"
  type = list(object({
    name   = string
    labels = optional(map(string), {})
  }))
}

variable "create_service_accounts" {
  description = "Create a service account in each namespace"
  type        = bool
  default     = true
}

variable "create_read_only_role" {
  description = "Create a cluster-wide read-only role and bind it to the namespace service accounts"
  type        = bool
  default     = true
}
