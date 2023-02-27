# internet gateway for public subnet

resource "aws_internet_gateway" "ig" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.environment}-ig"
    enviroment = "${var.environment}"
  }
}

# route for internet-gatway

resource "aws_route" "public_internet_gatway" {
  route_table_id = var.public_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.ig.id
}

 