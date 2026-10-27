variable "network_label" {
  description = "Label for the Civo network"
  type        = string
}

variable "firewall_name" {
  description = "Name for the Civo firewall"
  type        = string
}

variable "create_default_rules" {
  description = "Whether Civo creates its default firewall rules, which allow ALL TCP/UDP/ICMP inbound and outbound from 0.0.0.0/0. Ignored (forced to false) when ingress_rules or egress_rules is set"
  type        = bool
  default     = true
}

variable "ingress_rules" {
  description = "Inbound allow rules. Setting this (or egress_rules) replaces Civo's open-everything defaults. port_range is a port or range (\"6443\", \"80-443\"); omit it for icmp"
  type = list(object({
    label      = string
    protocol   = optional(string, "tcp")
    port_range = optional(string)
    cidr       = list(string)
  }))
  default = null
}

variable "egress_rules" {
  description = "Outbound allow rules. When custom rules are in use and this is left null, all outbound TCP/UDP/ICMP is allowed"
  type = list(object({
    label      = string
    protocol   = optional(string, "tcp")
    port_range = optional(string)
    cidr       = list(string)
  }))
  default = null
}

variable "allow_internal_traffic" {
  description = "With custom rules, also allow all inbound traffic from the network's own CIDR (node to node)"
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

