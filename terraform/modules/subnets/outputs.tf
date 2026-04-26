output "public_subnet_ids" {
  description = "List of public subnet IDs, paired by index with the availability zones"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs, paired by index with the availability zones"
  value       = aws_subnet.private[*].id
}
