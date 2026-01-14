resource "aws_eks_addon" "this" {
  for_each = { for addon in var.addons : addon.name => addon }

  cluster_name  = var.eks_cluster_name
  addon_name    = each.value.name
  addon_version = lookup(each.value, "addon_version", null)
}