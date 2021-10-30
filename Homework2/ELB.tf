resource "aws_elb" "web_elb" {
  name            = "web-elb"
  instances       = [aws_instance.nginx_web_srv_1a.id, aws_instance.nginx_web_srv_1b.id]
  security_groups = [aws_security_group.nginx_web_security_group.id]
  subnets         = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1b.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }

  tags = {
    "Name" = "${var.purpose_tag}_web_elb"
  }
}
