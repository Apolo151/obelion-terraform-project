variable "min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number

}

variable "max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of instances in the ASG"
  type        = number
}

variable "scaling_adjustment" {
  description = "Number of instances to add or remove when scaling"
  type        = number
}

variable "subnet_ids" {
  description = "Subnet IDs for the ASG"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for the ASG"
  type        = string
}

variable "web_sg_id" {
  description = "Security Group ID for the ASG"
  type        = string
}

variable "launch_template_id" {
  description = "Launch Template ID for the ASG"
  type        = string
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "abdallah"
}