# =============================================================================
# IAM policy attachments - AWS-managed policies attached to the EKS roles
# =============================================================================

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = var.eks_cluster_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_node" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  ])

  role       = var.eks_node_role_name
  policy_arn = each.value
}
