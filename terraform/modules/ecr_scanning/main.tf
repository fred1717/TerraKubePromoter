# =============================================================================
# ECR registry scanning configuration
# =============================================================================
# This resource applies account-wide to every ECR repository in the current
# AWS account and region. Only one aws_ecr_registry_scanning_configuration
# can exist per account per region — Terraform manages it as a singleton.
#
# The wildcard filter "*" matches every repository name, ensuring uniform
# scanning coverage for the current and all future repositories.
#
# Reference:
# https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-scanning.html
# =============================================================================

resource "aws_ecr_registry_scanning_configuration" "main" {
  scan_type = var.scan_frequency == "SCAN_ON_PUSH" ? "BASIC" : "ENHANCED"

  rule {
    scan_frequency = var.scan_frequency

    repository_filter {
      filter      = "*"
      filter_type = "WILDCARD"
    }
  }
}
