# =============================================================================
# ECR scanning module variables
# =============================================================================
# The aws_ecr_registry_scanning_configuration resource applies account-wide,
# not per-repository. Consequently, no project_name or environment inputs
# are defined here — the registry is shared across every project in the
# AWS account.
#
# scan_frequency is exposed as a variable to allow future switching between
# SCAN_ON_PUSH (basic scanning, free) and CONTINUOUS_SCAN (enhanced
# scanning, paid) without modifying module code.
# =============================================================================

variable "scan_frequency" {
  description = "ECR scan frequency: SCAN_ON_PUSH (basic, free) or CONTINUOUS_SCAN (enhanced, paid)"
  type        = string
  default     = "SCAN_ON_PUSH"

  validation {
    condition     = contains(["SCAN_ON_PUSH", "CONTINUOUS_SCAN"], var.scan_frequency)
    error_message = "scan_frequency must be either SCAN_ON_PUSH or CONTINUOUS_SCAN."
  }
}
