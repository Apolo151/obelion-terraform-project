resource "aws_launch_template" "launch_template" {
  name_prefix            = var.launch_template_name
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    wordpress_database_name     = var.wordpress_database_name
    wordpress_database_user     = var.wordpress_database_user
    wordpress_database_password = var.wordpress_database_password
    database_private_ip         = var.database_private_ip
  }))

  tags = {
    Name = "${var.env}-terraform-instance"
    env  = var.env
  }
}