output "eks_cluster_role_arn" {
  description = "ARN of the IAM role assumed by the EKS cluster"
  value       = aws_iam_role.eks_cluster.arn
}

output "eks_cluster_role_name" {
  description = "Name of the IAM role assumed by the EKS cluster, used by iam_policies for attachments"
  value       = aws_iam_role.eks_cluster.name
}

output "eks_node_role_arn" {
  description = "ARN of the IAM role assumed by the EKS worker nodes"
  value       = aws_iam_role.eks_node.arn
}

output "eks_node_role_name" {
  description = "Name of the IAM role assumed by the EKS worker nodes, used by iam_policies for attachments"
  value       = aws_iam_role.eks_node.name
}
