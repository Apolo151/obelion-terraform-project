output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "public_subnets_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "public_subnet_cidr_block" {
  value = aws_subnet.public_subnet[0].cidr_block
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "private_subnet_cidr_block" {
  value = aws_subnet.private_subnet.cidr_block
}

output "public_rtb_id" {
  value = aws_route_table.public_rtb.id
}

# output "private_rtb_id" {
#   value = aws_route_table.private_rtb.id
# }

output "web_sg_id" {
  value = aws_security_group.web_sg.id
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}
