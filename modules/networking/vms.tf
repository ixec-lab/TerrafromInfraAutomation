# creating vm

  # private servers instance playing the application 
resource "aws_instance" "private_vm" {
  count = var.instance_count
  ami = "ami-0557a15b87f6559cf"
  instance_type = "t2.small"
  key_name = "ssh"
  subnet_id = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.sg-private.id]
  user_data = "${file("./scripts/install.sh")}"
  tags = {
    Name = "private_vm-${count.index}"
  }
}

# this box is acting like a jump box to interact with other "private servers" located in private subnets

resource "aws_instance" "public_vm"{
  count = 1
  ami = "ami-0557a15b87f6559cf"
  instance_type = "t2.small"
  key_name = "ssh"
  subnet_id = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.sg-bastion.id]
  tags = {
    Name = "public_vm-${count.index}"
  }

 # just to show that we can do instance config with provisioing `file` and `remot_exec` with public ssh_able machines 
  #connection {
  #  type        = "ssh"
  #  host        = "${aws_instance.public_vm[0].public_ip}"
  #  user        = "ubuntu"
  #  private_key = "${file("ssh.pem")}"
  #}

  #provisioner "file" {
  #  source      = "./scripts/app.py"
  #  destination = "/home/ubuntu/app.py"
  #}

  #  provisioner "remote-exec" {
  #  inline = [
  #    "sudo python3 -m http.server 80&"
  #  ]
  #}
}