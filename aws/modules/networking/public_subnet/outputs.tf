output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "public_subnet_id" {
  value = aws_subnet.public.*.id
}