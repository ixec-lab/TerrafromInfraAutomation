output "vpc_id" {
  value = module.Networking.vpc_id
}

output "public_subnets_id" {
  value = module.Networking.public_subnets_id
}

output "private_subnets_id" {
  value = module.Networking.private_subnets_id
}

output "bastion_sg_id" {
  value = module.Networking.bastion_sg_id
}

output "private_sg_id" {
  value = module.Networking.private_sg_id
}

# output for security group ELB
#output "lb_sg_id" {
#  value = aws_security_group.sg-lb.id
#}

output "public_route_table" {
  value = module.Networking.public_route_table
}

output "private_route_table" {
  value = module.Networking.private_route_table
}

output "app_nodes_ip" {
    value = module.Networking.app_nodes_ip
}

output "nat_public_ip" {
    value = module.Networking.nat_public_ip
}