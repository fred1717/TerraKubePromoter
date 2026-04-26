output "eks_irsa_provider_arn" {
  description = "ARN of the OIDC provider used by EKS IRSA"
  value       = aws_iam_openid_connect_provider.eks_irsa.arn
}

output "github_actions_provider_arn" {
  description = "ARN of the OIDC provider used by GitHub Actions"
  value       = aws_iam_openid_connect_provider.github_actions.arn
}
