variable "vpc_id" {
  description = "ID of the VPC the route tables belong to"
  type        = string
}

variable "internet_gateway_id" {
  description = "ID of the Internet Gateway, target of the public default route"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs, associated with the public route table"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs, associated with the private route table"
  type        = list(string)
}

variable "name_prefix" {
  description = "Prefix used for the Name tag on each route table resource"
  type        = string
}
