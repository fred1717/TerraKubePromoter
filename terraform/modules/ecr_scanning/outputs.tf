# =============================================================================
# ECR scanning module outputs
# =============================================================================
# The registry scanning configuration produces no identifiers useful to
# downstream modules. The outputs below expose the active scan type and
# frequency for reference via `terraform output`, and to make the module's
# effect visible in plan summaries.
# =============================================================================

output "scan_type" {
  description = "Active ECR scan type: BASIC or ENHANCED"
  value       = aws_ecr_registry_scanning_configuration.main.scan_type
}

output "scan_frequency" {
  description = "Active ECR scan frequency: SCAN_ON_PUSH or CONTINUOUS_SCAN"
  value       = var.scan_frequency
}
