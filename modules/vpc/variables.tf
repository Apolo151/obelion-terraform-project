variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "abdallah_vpc"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.2.0.0/16"
}

variable "env" {
  description = "The environment for the VPC"
  type        = string
  default     = "abdallah"
}