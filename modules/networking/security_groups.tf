# security group to allow ssh from internet to bastion host (jump box)
 # this host is implemented just for testing purposes
resource "aws_security_group" "sg-bastion" {
  vpc_id = aws_vpc.vpc.id
  #depends_on = [aws_vpc.vpc]
  name = "${var.environment}-sg-bastion"
  description = "${var.environment}"

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  egress {
      from_port = 0
      to_port = 0
      protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
}

  # security groupe to allow private vm communicating with bastion host over ssh and http with load balancer

  resource "aws_security_group" "sg-private" {
    vpc_id = aws_vpc.vpc.id
    name = "${var.environment}-sg-private"
    description = "private security group for local vm"

    ingress{
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    # allow ssh traffic just from public subnet to 
    ingress{
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["10.0.1.0/24"]
    }


      egress {
      from_port = 0
      to_port = 0
      protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  }