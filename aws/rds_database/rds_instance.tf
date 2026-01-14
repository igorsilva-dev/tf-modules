# Generate random password for RDS
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*-_=+?"
}

# DB Subnet Group
resource "aws_db_subnet_group" "database" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.db_subnet_ids
  tags       = var.tags
}

# Security Group for RDS
resource "aws_security_group" "database" {
  name        = "${var.identifier}-sg"
  description = "Security group for ${var.identifier} RDS instance"
  vpc_id      = var.vpc_id
  tags        = var.tags

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = var.allowed_security_group_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS Instance
resource "aws_db_instance" "database" {
  identifier     = var.identifier
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage = var.allocated_storage
  storage_type      = "gp3"

  db_name  = var.db_name
  username = var.username
  password = random_password.db_password.result

  db_subnet_group_name   = aws_db_subnet_group.database.name
  vpc_security_group_ids = [aws_security_group.database.id]

  skip_final_snapshot        = !var.enable_backups
  backup_retention_period    = var.enable_backups ? var.backup_retention_days : 0
  backup_window              = var.enable_backups ? var.backup_window : null
  publicly_accessible        = false
  auto_minor_version_upgrade = false

  tags = var.tags
}

# AWS Secrets Manager secret for database credentials
resource "aws_secretsmanager_secret" "db_credentials" {
  name                    = var.secrets_identifier != "" ? "${var.secrets_identifier}" : "${var.identifier}/db_credentials"
  description             = "Database credentials for ${var.identifier}"
  recovery_window_in_days = 7
  tags                    = var.tags

  depends_on = [aws_db_instance.database]
}

# Store credentials in the secret
resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.username
    password = random_password.db_password.result
    hostname = aws_db_instance.database.address
    port     = var.db_port
    database = var.db_name
  })

  depends_on = [aws_db_instance.database]
}
