 # security groupe to allow private vm communicating with bastion host over ssh and http with load balancer

  resource "aws_security_group" "sg-private" {
    vpc_id = var.vpc_id
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

# creating vm

  # private servers instance playing the application 
resource "aws_instance" "private_vm" {
  count = var.instance_count
  ami = "ami-0557a15b87f6559cf"
  instance_type = "t2.small"
  # key_name = "ssh"
  subnet_id =  var.private_subnet_id[0]
  vpc_security_group_ids = [aws_security_group.sg-private.id]
  user_data = "${file("./aws/scripts/install.sh")}"
  tags = {
    Name = "private_vm-${count.index}"
  }
}

