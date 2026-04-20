# =============================================================================
# Endpoints module variables
# =============================================================================

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "environment" {
  description = "Deployment environment for resource naming"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where endpoints are created"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC for security group rules"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for endpoint network interfaces"
  type        = list(string)
}

variable "aws_region" {
  description = "AWS region for endpoint service names"
  type        = string
}

variable "private_route_table_id" {
  description = "ID of the private route table for the S3 gateway endpoint"
  type        = string
}
