output "nat_ip" {
  value = aws_eip.nat_eip.public_ip
}

output "nat_id" {
  value = aws_nat_gateway.nat_gw.id
}