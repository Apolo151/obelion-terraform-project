output "vpc_host_id" {
  value = module.vpc.vpc_id
}

output "igw_id" {
  value = module.igw.igw_id
}

output "nat_id" {
  value = module.nat.nat_id
}

output "public_subnet_id" {
  value = module.subnets.public_subnet_id
}

output "public_subnet_cidr_block" {
  value = module.subnets.public_subnet_cidr_block
}

output "private_subnet_id" {
  value = module.subnets.private_subnet_id
}

output "private_subnet_cidr_block" {
  value = module.subnets.private_subnet_cidr_block
}

output "web_sg_id" {
  value = module.security_groups.web_sg_id
}

output "db_sg_id" {
  value = module.security_groups.db_sg_id
}

output "public_rtb_id" {
  value = module.route_tables.public_rtb_id
}

output "private_rtb_id" {
  value = module.route_tables.private_rtb_id
}