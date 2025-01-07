variable "env" {
  description = "The environment for the VPC"
  type        = string
  default     = "abdallah"
}

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

variable "igw_name" {
  description = "The name of the internet gateway"
  type        = string
  default     = "abdallah_igw"
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet"
  default     = ""
}

variable "availability_zone" {
  description = "The availability zone for the subnet"
  default     = ""
}

variable "public_subnet_name" {
  description = "The name of the public subnet"
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