variable "launch_template_name" {
  description = "The name of the launch template"
  type        = string
}

variable "image_id" {
  description = "The ID of the AMI"
  type        = string
}

variable "instance_type" {
  description = "The type of the instance"
  type        = string
}

variable "key_name" {
  description = "The name of the key pair"
  type        = string
}

variable "user_data" {
  description = "The user data for the instance"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "The security group IDs for the instance"
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "The IAM instance profile for the instance"
  type        = string
}

variable "monitoring" {
  description = "The monitoring settings for the instance"
  type        = map(any)
}

variable "tag_specifications" {
  description = "The tags for the instance"
  type        = list(map)
}

variable "env" {
  description = "The environment for the resources"
  type        = string
  default     = "abdallah"
}

variable "region" {
  description = "The region for the resources"
  type        = string
  default     = "us-east-1"
}