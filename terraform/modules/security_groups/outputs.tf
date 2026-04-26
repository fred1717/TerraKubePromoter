output "endpoints_security_group_id" {
  description = "ID of the security group attached to the VPC interface endpoints"
  value       = aws_security_group.endpoints.id
}
