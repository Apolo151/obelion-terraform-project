output "vpc_host_id" {
  value = module.vpc.vpc_id
}

output "igw_id" {
  value = module.vpc.igw_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

output "private_subnet_cidr_block" {
  value = module.vpc.private_subnet_cidr_block
}

output "web_sg_id" {
  value = module.vpc.web_sg_id
}

output "db_sg_id" {
  value = module.vpc.db_sg_id
}

output "public_rtb_id" {
  value = module.vpc.public_rtb_id
}

# output "private_rtb_id" {
#   value = module.route_tables.private_rtb_id
# }

output "db_instance_private_ip" {
  value = module.ec2.db_instance_private_ip
}

output "launch_template_id" {
  value = module.ec2.launch_template_id
}

output "asg_id" {
  value = module.ec2.asg_id
}

output "load_balancer_dns" {
  value = module.ec2.load_balancer_dns
}