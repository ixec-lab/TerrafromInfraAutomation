### NAT setup : servers in private subnets can have access to the internet to donwload stuffs 
### but they can not be visible from out side, I prefer setup nat beacause it create a good security layer
### than a jump box exposed to public internet, in case of successful compromising scenarios we expose our 
### network to danger

# Elastic-IP (eip) for NAT

resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [var.intenet_gateway_ig]
}

# NAT

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     =  var.public_subnet_id[0]

  tags = {
    Name        = "nat"
    Environment = "${var.environment}"
  }
}

# Route for NAT

resource "aws_route" "private_nat_gateway" {
  route_table_id         = var.private_RT_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}