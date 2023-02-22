# network load balancer

resource "aws_lb" "load_balancer" {
  name = "${var.environment}-load-balancer"
  internal = false
  load_balancer_type = "network"
  subnets = [aws_subnet.public[0].id]
}

# target group 

resource "aws_lb_target_group" "http" {
  name = "${var.environment}-load-balancer-target-groupe"

  port = 80
  protocol = "TCP"

  vpc_id = aws_vpc.vpc.id

  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 5
    path = "/"
    interval = 10
    port = 80
    protocol = "HTTP"
  }
}

# load_balancer listener

resource "aws_lb_listener" "listen-http" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port = "80"
  protocol = "TCP"
  depends_on = [aws_lb_target_group.http] # make sure to create target group before setting up listener
  default_action {
    target_group_arn = aws_lb_target_group.http.arn
    type = "forward"
  }
}

resource "aws_lb_target_group_attachment" "target_servers" {
  target_group_arn = aws_lb_target_group.http.arn
  count = var.instance_count
  target_id = aws_instance.private_vm[count.index].id
  port = 80
}

# classic load balancer for tests & comparaison

#resource "aws_elb" "load_balancer" {
#  subnets = [aws_subnet.public[0].id]
#  security_groups = [aws_security_group.sg-lb.id]
#  name = "${var.environment}-load-balancer"

#  listener {
#   instance_port = 80
#    instance_protocol = "http"
#    lb_port = 80
#    lb_protocol = "http"
#  }
#
#  health_check {
#    healthy_threshold = 3
#    unhealthy_threshold = 2
#    timeout = 5
#    target = "HTTP:80/"
#    interval = 10
#  }

  # attachment with private vms

  #instances = ["${aws_instance.private_vm[0].id}","${aws_instance.private_vm[1].id}"]
  #idle_timeout = 60

  #tags = {
  #  Name = "${var.environment}-load_balancer"
  #} 
#}