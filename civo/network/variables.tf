variable "network_label" {
  description = "Label for the Civo network"
  type        = string   
}

variable "firewall_name" {
  description = "Name for the Civo firewall"
  type        = string
}

variable "create_default_rules" {
  description = "Whether to create default rules for the firewall"
  type        = bool
  default     = true  
}

