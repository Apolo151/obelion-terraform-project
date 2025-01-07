variable "env" {
  description = "The environment in which the resources are created"
  default     = "abdallah"
}

variable "launch_template_name" {
  description = "The name of the launch template"
  type        = string
}

variable "ami_id" {
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

variable "vpc_security_group_ids" {
  description = "The security group IDs for the instance"
  type        = list(string)
}

variable "wordpress_database_name" {
  description = "The name of the WordPress database"
  type        = string
}

variable "wordpress_database_user" {
  description = "The username for the WordPress database"
  type        = string
}

variable "wordpress_database_password" {
  description = "The password for the WordPress database"
  type        = string

}

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

variable "db_ami" {
  description = "The AMI to use for the EC2 instance"
}

variable "db_instance_type" {
  description = "The type of instance to launch"
}

variable "db_subnet_id" {
  description = "The subnet ID to launch the database instance in"
}

variable "ssh_key_name" {
  description = "The name of the SSH key to use"
}

variable "security_group_ids" {
  type        = list(string)
  description = "The security group IDs to attach to the instance"
}