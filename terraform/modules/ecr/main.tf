# =============================================================================
# ECR repository
# =============================================================================
# Single repository for the Flask application image. Environment separation
# is handled at the Kubernetes manifest layer (dev/staging/production
# namespaces pulling different image tags), not at the registry layer.
# =============================================================================

locals {
  repository_name = "${var.project_name}-${var.environment}-app"
}

# -----------------------------------------------------------------------------
# Repository
# -----------------------------------------------------------------------------
# image_tag_mutability = IMMUTABLE prevents a tag from being reassigned to a
# different image, which is a supply-chain prerequisite for GitOps.
#
# scan_on_push = true triggers the free basic vulnerability scan on every
# pushed image, detecting known CVEs in the image layers.
#
# AES256 encryption at rest uses AWS-managed keys, the standard private
# repository default.
# -----------------------------------------------------------------------------

resource "aws_ecr_repository" "app" {
  name                 = local.repository_name
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }
}

# -----------------------------------------------------------------------------
# Lifecycle policy
# -----------------------------------------------------------------------------
# Rule 1: retain the last 10 tagged images, expire older tagged images.
# Rule 2: expire untagged images after 7 days.
#
# Rules are evaluated in priority order (lowest number first). Rule 1 runs
# before rule 2, so untagged images produced by a newer build do not count
# against the tagged image retention limit.
# -----------------------------------------------------------------------------

resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Retain the last 10 tagged images"
        selection = {
          tagStatus      = "tagged"
          tagPatternList = ["*"]
          countType      = "imageCountMoreThan"
          countNumber    = 10
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Expire untagged images after 7 days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 7
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
