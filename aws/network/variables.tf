variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet configurations"
  type = list(object({
    az            = string
    cidr_newbits  = number
    cidr_netnum   = number
    subnet_prefix = optional(string, "")
    tags          = map(string)
  }))
}

variable "private_subnets" {
  description = "List of private subnet configurations"
  type = list(object({
    az            = string
    cidr_newbits  = number
    cidr_netnum   = number
    subnet_prefix = optional(string, "")
    create_nat_gw = optional(bool, false)
    tags          = map(string)
  }))
}

variable "common_tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}