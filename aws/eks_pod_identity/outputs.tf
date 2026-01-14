output "role_arn" {
  description = "ARN of the IAM role for Pod Identity"
  value       = aws_iam_role.pod_identity_role.arn
}

output "role_name" {
  description = "Name of the IAM role for Pod Identity"
  value       = aws_iam_role.pod_identity_role.name
}

output "policy_arn" {
  description = "ARN of the IAM policy"
  value       = aws_iam_policy.pod_identity_policy.arn
}

output "pod_identity_association_id" {
  description = "ID of the EKS Pod Identity Association"
  value       = aws_eks_pod_identity_association.pod_identity.association_id
}
