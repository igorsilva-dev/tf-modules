resource "aws_eks_node_group" "eks_managed_node_group" {
  for_each        = var.node_groups
  cluster_name    = var.cluster_name
  version         = var.kubernetes_version
  node_group_name = each.value.node_group_name
  node_role_arn   = aws_iam_role.eks_mng_role.arn
  subnet_ids      = each.value.subnet_ids
  tags = merge(
    var.common_tags,
    {
      Name = each.value.node_group_name
    }
  )

  capacity_type  = each.value.capacity_type
  instance_types = each.value.instance_types

  scaling_config {
    desired_size = each.value.desired_size
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_mng_role_attachment_worker,
    aws_iam_role_policy_attachment.eks_mng_role_attachment_ecr,
    aws_iam_role_policy_attachment.eks_mng_role_attachment_cni
  ]
}