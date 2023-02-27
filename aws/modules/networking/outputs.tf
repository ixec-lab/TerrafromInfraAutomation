output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_id" {
  value = module.private_subnet.private_subnet_id
}

output "target_group_arn_suffix" {
  value = module.load_balancer.target_group_arn_suffix
}

output "load_balancer_arn_suffix" {
  value = module.load_balancer.load_balancer_arn_suffix
}

output "Lb_DNS" {
  value = module.load_balancer.Lb_DNS
}

# output "public_subnets_id" {
#   value = ["${aws_subnet.public.*.id}"]
# }

# output "private_subnets_id" {
#   value = ["${aws_subnet.private.*.id}"]
# }

# output "bastion_sg_id" {
#   value = aws_security_group.sg-bastion.id
# }

# output "private_sg_id" {
#   value = aws_security_group.sg-private.id
# }

# # output for security group ELB
# #output "lb_sg_id" {
# #  value = aws_security_group.sg-lb.id
# #}

# output "public_route_table" {
#   value = aws_route_table.public.id
# }

# output "private_route_table" {
#   value = aws_route_table.private.id
# }

# output "app_nodes_ip" {
#     value = ["${aws_instance.private_vm.*.private_ip}"]
# }

# output "nat_public_ip" {
#     value = aws_eip.nat_eip.public_ip
# }