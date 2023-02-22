# This security group was setuped for testing ELB
  #resource "aws_security_group" "sg-lb" {
  #  vpc_id = aws_vpc.vpc.id
  #  name = "${var.environment}-sg-private-lb"
  #  description = "security group for load balancer allowing http from internet"

  #  ingress{
  #    from_port = 80
  #    to_port = 80
  #    protocol = "tcp"
  #    cidr_blocks = ["0.0.0.0/0"]
  #  }

  #  egress {
  #    from_port = 0
  #    to_port = 0
  #    protocol = -1
  #    cidr_blocks = ["0.0.0.0/0"]
  #  }
  #}