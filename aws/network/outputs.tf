output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for s in values(aws_subnet.public) : s.id]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for s in values(aws_subnet.private) : s.id]
}

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value       = [for ngw in values(aws_nat_gateway.ngw) : ngw.id]
}

output "kubernetes_private_subnet_ids" {
  description = "List of private subnet IDs tagged with component = kubernetes"
  value       = [for s in values(aws_subnet.private) : s.id if lookup(s.tags, "component", "") == "kubernetes"]
}

output "database_private_subnet_ids" {
  description = "List of private subnet IDs tagged with component = database"
  value       = [for s in values(aws_subnet.private) : s.id if lookup(s.tags, "component", "") == "db"]
}