variable "network_label" {
  description = "Label for the Civo network"
  type        = string
  default     = "example-network"
}

variable "firewall_name" {
  description = "Name for the Civo firewall"
  type        = string
  default     = "example-firewall"
}

variable "create_default_rules" {
  description = "Create default firewall rules"
  type        = bool
  default     = true
}
