# =============================================================================
# Outputs — IAM role ARNs consumed by the GitHub Actions workflow files
# =============================================================================

output "ecr_push_role_arn" {
  description = "ARN of the role assumed by app-ci.yml to push images to ECR"
  value       = aws_iam_role.ecr_push.arn
}

output "terraform_role_arn" {
  description = "ARN of the role assumed by terraform-ci.yml to apply Terraform"
  value       = aws_iam_role.terraform.arn
}

output "promote_role_arn" {
  description = "ARN of the role assumed by promote.yml to read ECR image digests"
  value       = aws_iam_role.promote.arn
}

output "oidc_provider_arn" {
  description = "ARN of the GitHub OIDC provider (for cross-reference and audit)"
  value       = aws_iam_openid_connect_provider.github.arn
}
