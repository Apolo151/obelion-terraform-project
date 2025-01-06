variable "public_subnet_id" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "nat_name" {
  description = "The name of the NAT Gateway"
  type        = string
}

variable "env" {
  description = "The environment for the resources"
  type        = string
  default     = "abdallah"
}