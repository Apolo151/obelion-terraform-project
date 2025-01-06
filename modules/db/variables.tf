variable "ami" {
  description = "The AMI to use for the EC2 instance"
}

variable "instance_type" {
  description = "The type of instance to launch"
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
}

variable "ssh_key_name" {
  description = "The name of the SSH key to use"
}

variable "security_group_ids" {
  type        = list(string)
  description = "The security group IDs to attach to the instance"
}

variable "env" {
  description = "The environment in which the resources are created"
  default     = "abdallah"
}