#subnet private

resource "aws_subnet" "private" {
  vpc_id = var.vpc_id
  count = length(var.private_subnets_cidr)
  cidr_block = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.availability_zones,count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.environment}-${element(var.availability_zones, count.index)}-private-subnet"
  }
}


# routing table for private subnet
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.environment}-private-rt-table"
    description = "${var.environment}"
  }
}

# Route table associations for pirvate subnets

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets_cidr)
  subnet_id = aws_subnet.private[0].id
  route_table_id = aws_route_table.private.id
}


