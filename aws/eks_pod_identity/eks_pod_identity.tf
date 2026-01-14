# Get current AWS account and region
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# IAM Policy Document for Pod Identity assume role
data "aws_iam_policy_document" "pod_identity_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

# IAM Role for Pod Identity
resource "aws_iam_role" "pod_identity_role" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.pod_identity_assume_role.json
  tags               = var.tags
}

# IAM Policy
resource "aws_iam_policy" "pod_identity_policy" {
  name   = var.policy_name != null ? var.policy_name : "${var.role_name}-policy"
  policy = var.policy_document
  tags   = var.tags
}

# Attach policy to role
resource "aws_iam_role_policy_attachment" "pod_identity_attachment" {
  role       = aws_iam_role.pod_identity_role.name
  policy_arn = aws_iam_policy.pod_identity_policy.arn
}

# EKS Pod Identity Association
resource "aws_eks_pod_identity_association" "pod_identity" {
  cluster_name    = var.cluster_name
  namespace       = var.namespace
  service_account = var.service_account_name
  role_arn        = aws_iam_role.pod_identity_role.arn
}



