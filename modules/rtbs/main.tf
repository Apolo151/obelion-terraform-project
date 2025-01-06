resource "aws_route_table" "public_rtb" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "${var.env}-public_rtb"
    env  = var.env
  }
}

# Associate route table to public subnets
resource "aws_route_table_association" "public_associations" {
  for_each = toset(var.public_subnet_ids)

  subnet_id      = each.value
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table" "private_rtb" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }

  tags = {
    Name = "${var.env}-private_rtb"
    env  = var.env
  }
}

# Associate route table to private subnets
resource "aws_route_table_association" "private_associations" {
  for_each = toset(var.private_subnet_ids)

  subnet_id      = each.value
  route_table_id = aws_route_table.private_rtb.id
}

