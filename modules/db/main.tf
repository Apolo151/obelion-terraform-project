# create ec2 instance
resource "aws_instance" "db" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.ssh_key_name
  vpc_security_group_ids = var.security_group_ids

  user_data = file("${path.module}/mysql_db_user_data.sh")

  tags = {
    Name = "db-${var.env}"
    env  = var.env
  }
}