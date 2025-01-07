resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.vpc_name
    env  = var.env
  }
}

# Subnets
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr_block[count.index]
  availability_zone       = var.availability_zone[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = var.public_subnet_name[count.index]
    env  = var.env
  }
  count = 2
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = var.availability_zone[0]
  tags = {
    Name = var.private_subnet_name
    env  = var.env
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = var.igw_name
    env  = var.env
  }
}

resource "aws_security_group" "web_sg" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = var.web_sg_name
  description = "Allow HTTP and HTTPS inbound traffic + (SSH)"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_sg" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = var.db_sg_name
  description = "Allow MySQL inbound traffic"

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    # allow traffic from web security group
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Route Tables
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.env}-public_rtb"
    env  = var.env
  }
}

# Associate route table to public subnets
resource "aws_route_table_association" "public_associations" {
  count = length(aws_subnet.public_subnet)

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rtb.id
}

# resource "aws_route_table" "private_rtb" {
#   vpc_id = aws_vpc.main_vpc.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = var.nat_id
#   }

#   tags = {
#     Name = "${var.env}-private_rtb"
#     env  = var.env
#   }
# }

# # Associate route table to private subnets
# resource "aws_route_table_association" "private_associations" {
#   for_each = toset(var.private_subnet_ids)

#   subnet_id      = each.value
#   route_table_id = aws_route_table.private_rtb.id
# }

