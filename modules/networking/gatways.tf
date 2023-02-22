# internet gateway for public subnet

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-ig"
    enviroment = "${var.environment}"
  }
}

 ### NAT setup : servers in private subnets can have access to the internet to donwload stuffs 
 ### but they can not be visible from out side, I prefer setup nat beacause it create a good security layer
 ### than a jump box exposed to public internet, in case of successful compromising scenarios we expose our 
 ### network to danger

# Elastic-IP (eip) for NAT

resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}

# NAT

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name        = "nat"
    Environment = "${var.environment}"
  }
}