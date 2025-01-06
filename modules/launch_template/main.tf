resource "aws_launch_template" "launch_template" {
  name_prefix            = var.launch_template_name
  image_id               = var.image_id
  instance_type          = var.instance_type
  key_name               = data.aws_key_pair.my_key_pair.key_name
  user_data              = file("userdata.sh")
  vpc_security_group_ids = [module.security_groups.web_sg_id]

}