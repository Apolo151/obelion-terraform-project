variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = ""
}

variable "availability_zone" {
  description = "The availability zone for the subnet"
  type        = string
  default     = ""
}

variable "public_subnet_name" {
  description = "The name of the public subnet"
  type        = string
  default     = ""
}

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = ""
}

variable "private_subnet_name" {
  description = "The name of the private subnet"
  type        = string
  default     = ""
}

variable "env" {
  description = "My Env"
  type        = string
  default     = "abdallah"
}