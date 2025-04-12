output "launch_template_id" {
  value = aws_launch_template.launch_template.id
}

output "asg_id" {
  value = aws_autoscaling_group.asg.id
}

output "load_balancer_dns" {
  value = aws_lb.lb.dns_name
}

output "db_instance_id" {
  value = aws_instance.db.id
}

output "db_instance_private_ip" {
  value = aws_instance.db.private_ip
}