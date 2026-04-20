# =============================================================================
# Endpoints module outputs
# =============================================================================

output "interface_endpoint_ids" {
  description = "Map of interface endpoint names to their IDs"
  value       = { for k, v in aws_vpc_endpoint.interface : k => v.id }
}

output "s3_endpoint_id" {
  description = "ID of the S3 gateway endpoint"
  value       = aws_vpc_endpoint.s3.id
}

output "security_group_id" {
  description = "ID of the security group attached to interface endpoints"
  value       = aws_security_group.endpoints.id
}
