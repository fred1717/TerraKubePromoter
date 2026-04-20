# =============================================================================
# Backend module variables
# =============================================================================

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "environment" {
  description = "Deployment environment for resource naming"
  type        = string
}
