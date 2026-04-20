# =============================================================================
# ECR module variables
# =============================================================================
# Inputs passed from the root module. No defaults, consistent with the other
# child modules. All other ECR settings (scan_on_push, image_tag_mutability,
# lifecycle policy) are defined as module-level constants in main.tf,
# reflecting project-wide best-practice choices rather than per-deployment
# configuration.
# =============================================================================

variable "project_name" {
  description = "Project name used for repository naming and tagging"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g. dev, staging, production)"
  type        = string
}
