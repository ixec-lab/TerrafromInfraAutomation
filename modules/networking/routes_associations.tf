# Route table associations for Public Subnets
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = aws_subnet.public[0].id
  route_table_id = aws_route_table.public.id
}

# Route table associations for pirvate subnets

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets_cidr)
  subnet_id = aws_subnet.private[0].id
  route_table_id = aws_route_table.private.id
}