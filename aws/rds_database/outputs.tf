output "db_endpoint" {
  description = "The connection endpoint of the RDS instance"
  value       = aws_db_instance.database.endpoint
}

output "db_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.database.address
}

output "db_port" {
  description = "The port of the RDS instance"
  value       = aws_db_instance.database.port
}

output "db_name" {
  description = "The database name"
  value       = aws_db_instance.database.db_name
}

output "db_username" {
  description = "The master username"
  value       = aws_db_instance.database.username
  sensitive   = true
}

output "security_group_id" {
  description = "The security group ID for the RDS instance"
  value       = aws_security_group.database.id
}

output "db_credentials_secret_arn" {
  description = "The ARN of the Secrets Manager secret containing database credentials"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "db_credentials_secret_name" {
  description = "The name of the Secrets Manager secret containing database credentials"
  value       = aws_secretsmanager_secret.db_credentials.name
}

output "db_credentials" {
  description = "Database credentials (use secret_name to retrieve from Secrets Manager)"
  value = {
    secret_name = aws_secretsmanager_secret.db_credentials.name
    secret_arn  = aws_secretsmanager_secret.db_credentials.arn
    username    = var.username
    database    = var.db_name
    hostname    = aws_db_instance.database.address
    port        = var.db_port
  }
  sensitive = true
}

output "db_instance_endpoint" {
  description = "The connection endpoint of the RDS instance"
  value       = aws_db_instance.database.endpoint
}

output "db_instance_port" {
  description = "The port of the RDS instance"
  value       = aws_db_instance.database.port
}

output "db_instance_name" {
  description = "The database name"
  value       = aws_db_instance.database.db_name
}

output "db_instance_resource_id" {
  description = "The resource ID of the RDS instance"
  value       = aws_db_instance.database.resource_id
}

