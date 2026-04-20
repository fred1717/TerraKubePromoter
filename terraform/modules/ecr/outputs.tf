# =============================================================================
# ECR module outputs
# =============================================================================

output "repository_url" {
  description = "URL of the ECR repository, used by docker push and Kubernetes manifests"
  value       = aws_ecr_repository.app.repository_url
}

output "repository_arn" {
  description = "ARN of the ECR repository, used in IAM policies for image pull permissions"
  value       = aws_ecr_repository.app.arn
}

output "repository_name" {
  description = "Name of the ECR repository, used in CI/CD workflows"
  value       = aws_ecr_repository.app.name
}
