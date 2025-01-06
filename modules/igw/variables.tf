variable "igw_name" {
  description = "The name of the internet gateway"
  type        = string
  default     = "abdallah_igw"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "env" {
  description = "My Env"
  type        = string
  default     = "abdallah"
}