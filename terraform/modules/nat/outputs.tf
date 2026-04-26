output "nat_gateway_id" {
  description = "ID of the NAT gateway"
  value       = aws_nat_gateway.main.id
}

output "nat_gateway_eip" {
  description = "Elastic IP address attached to the NAT gateway"
  value       = aws_eip.nat.public_ip
}
