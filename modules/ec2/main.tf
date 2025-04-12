# create database ec2 instance
resource "aws_instance" "db" {
  ami                    = var.db_ami
  instance_type          = var.db_instance_type
  subnet_id              = var.db_subnet_id
  key_name               = var.ssh_key_name
  vpc_security_group_ids = var.security_group_ids

  user_data = file("${path.module}/mysql_db_user_data.sh")

  tags = {
    Name = "db-${var.env}"
    env  = var.env
  }
}

resource "aws_launch_template" "launch_template" {
  name_prefix            = var.launch_template_name
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids

  user_data = base64encode(templatefile("${path.module}/wp_user_data.sh", {
    wordpress_database_name     = var.wordpress_database_name
    wordpress_database_user     = var.wordpress_database_user
    wordpress_database_password = var.wordpress_database_password
    database_private_ip         = aws_instance.db.private_ip
  }))

  tags = {
    Name = "${var.env}-terraform-instance"
    env  = var.env
  }

  depends_on = [aws_instance.db]
}

# Target Group
resource "aws_lb_target_group" "target_group" {
  name        = "${var.env}-terraform-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
}

# Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  name = "${var.env}-ASG"

  min_size          = var.min_size
  max_size          = var.max_size
  desired_capacity  = var.desired_capacity
  health_check_type = "ELB"

  vpc_zone_identifier = var.subnet_ids

  target_group_arns = [aws_lb_target_group.target_group.arn]

  tag {
    key                 = "Name"
    value               = "${var.env}-asg-instance"
    propagate_at_launch = true
  }
}

# Autoscaling Policy
resource "aws_autoscaling_policy" "asg_policy" {
  name                   = "${var.env}-asg-policy"
  scaling_adjustment     = var.scaling_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_description   = "Monitors CPU utilization"
  alarm_actions       = [aws_autoscaling_policy.asg_policy.arn]
  alarm_name          = "scale-up-on-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "50"
  evaluation_periods  = "5"
  period              = "30"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  actions_enabled = true
}

#Load balancer
resource "aws_lb" "lb" {
  name               = "${var.env}-terraform-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.web_sg_id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "${var.env}-terraform-lb"
    env  = var.env
  }
}

# Listener
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
