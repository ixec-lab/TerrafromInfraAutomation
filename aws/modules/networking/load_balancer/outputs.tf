output "target_group_arn_suffix" {
  value = aws_lb_target_group.http.arn_suffix
}

output "load_balancer_arn_suffix" {
  value = aws_lb.load_balancer.arn_suffix
}

output "Lb_DNS" {
  value = aws_lb.load_balancer.dns_name
}