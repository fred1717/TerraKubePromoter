variable "github_org" {
  description = "GitHub organisation or user that owns the repository"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "ecr_repository_arn" {
  description = "ARN of the ECR repository the push role is allowed to write to"
  type        = string
}

variable "terraform_state_bucket_arn" {
  description = "ARN of the S3 bucket holding the Terraform state"
  type        = string
}
