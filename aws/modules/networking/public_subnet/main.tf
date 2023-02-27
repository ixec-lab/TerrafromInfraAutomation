# subnet public

resource "aws_subnet" "public" {
  vpc_id = var.vpc_id   
  count = length(var.public_subnets_cidr)
  cidr_block = element(var.public_subnets_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-${element(var.availability_zones, count.index)}-public-subnet"
  }
}

# routing table for public subnet

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.environment}-public-rt-table"
    description = "${var.environment}"
  }
}


# Route table associations for Public Subnets
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = aws_subnet.public[0].id
  route_table_id = aws_route_table.public.id
}