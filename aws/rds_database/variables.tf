variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "engine" {
  description = "The database engine type"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "The database engine version"
  type        = string
  default     = "15.4"
}

variable "db_port" {
  description = "The database port"
  type        = number
  default     = 5432
}

variable "instance_class" {
  description = "The instance type for the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "The allocated storage in GB"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "The name of the database to create"
  type        = string
  default     = "postgres"
}

variable "username" {
  description = "The master username for the database"
  type        = string
  default     = "postgres"
}

variable "password" {
  description = "The password for the master user (if not provided, a secure random password will be generated)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "vpc_id" {
  description = "The VPC ID where the RDS instance will be deployed"
  type        = string
}

variable "db_subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "allowed_security_group_ids" {
  description = "List of security group IDs allowed to connect to the database"
  type        = list(string)
  default     = []
}

variable "secrets_identifier" {
  description = "The identifier path for the secrets manager secret"
  type        = string
  default     = ""
}

variable "enable_backups" {
  description = "Enable daily automated backups"
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  description = "Number of days to retain backups (1-35)"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Time window for daily backups (UTC, format: HH:MM-HH:MM)"
  type        = string
  default     = "03:00-04:00"
}

variable "tags" {
  description = "Tags to apply to the RDS instance"
  type        = map(string)
  default     = {}
}
