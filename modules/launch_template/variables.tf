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

variable "database_private_ip" {
  description = "The private IP of the database instance"
  type        = string
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

variable "env" {
  description = "The environment for the resources"
  type        = string
  default     = "abdallah"
}