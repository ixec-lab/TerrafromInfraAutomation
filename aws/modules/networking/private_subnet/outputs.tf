output "private_RT_id" {
  value = aws_route_table.private.id
}

output "private_subnet_id" {
  value = aws_subnet.private.*.id
}