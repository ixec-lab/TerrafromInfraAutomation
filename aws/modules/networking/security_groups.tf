# # security group to allow ssh from internet to bastion host (jump box)
#  # this host is implemented just for testing purposes
# resource "aws_security_group" "sg-bastion" {
#   vpc_id = aws_vpc.vpc.id
#   #depends_on = [aws_vpc.vpc]
#   name = "${var.environment}-sg-bastion"
#   description = "${var.environment}"

#   ingress {
#       from_port = 22
#       to_port = 22
#       protocol = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }

#   egress {
#       from_port = 0
#       to_port = 0
#       protocol = -1
#       cidr_blocks = ["0.0.0.0/0"]
#     }
# }

 