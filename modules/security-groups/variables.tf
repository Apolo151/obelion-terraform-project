variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "web_sg_name" {
  description = "The name of the security group"
  type        = string
  default     = "web_sg"
}

variable "db_sg_name" {
  description = "The name of the security group"
  type        = string
  default     = "db_sg"
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = ""
}

variable "env" {
  description = "The environment"
  type        = string
  default     = "abdallah"
}