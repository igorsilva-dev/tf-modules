variable "network_label" {
  description = "Label for the Civo network"
  type        = string
}

variable "firewall_name" {
  description = "Name for the Civo firewall"
  type        = string
}

variable "create_default_rules" {
  description = "Whether to create default firewall rules (allow SSH, HTTP, HTTPS inbound)"
  type        = bool
  default     = true
}

variable "dns_domain" {
  description = "DNS domain name to register with Civo (leave empty to skip DNS setup)"
  type        = string
  default     = ""
}

variable "dns_records" {
  description = "List of DNS records to create under the domain. Only used when dns_domain is set"
  type = list(object({
    type  = string
    name  = string
    value = string
    ttl   = number
  }))
  default = []
}

