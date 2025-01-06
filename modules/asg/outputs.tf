output "asg_id" {
  value = aws_autoscaling_group.asg.id
}

output "load_balancer_dns" {
  value = aws_lb.lb.dns_name
}