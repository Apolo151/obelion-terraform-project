output "public_subnet_id" {
  value = aws_subnet.public_subnet[0].id
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