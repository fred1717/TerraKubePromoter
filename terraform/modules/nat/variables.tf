variable "public_subnet_id" {
  description = "ID of the public subnet the NAT gateway is placed in"
  type        = string
}

variable "private_route_table_id" {
  description = "ID of the private route table the default route to the NAT gateway is added to"
  type        = string
}

variable "name_prefix" {
  description = "Prefix used for the Name tag on each NAT-related resource"
  type        = string
}
