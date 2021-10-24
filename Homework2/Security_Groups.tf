##################################################################################
# SECURITY_GROUPS
##################################################################################
resource "aws_default_security_group" "default_security_group" {
  vpc_id = aws_vpc.assignment_vpc.id

  tags = {
    "Name" = "${var.purpose_tag}_default_security_group"
  }
}

resource "aws_security_group" "nginx_web_security_group" {
  name   = "nginx_web_security_group"
  vpc_id = aws_vpc.assignment_vpc.id

  # Allow All HTTP Inbound
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  # Allow All SSH Inbound
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # Allow All Any Outbound
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }

  tags = {
    "Name" = "${var.purpose_tag}_nginx_web_security_group"
  }
}

resource "aws_security_group" "db_security_group" {
  name   = "db_security_group"
  vpc_id = aws_vpc.assignment_vpc.id

  # Allow All Any Outbound
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }

  tags = {
    "Name" = "${var.purpose_tag}_db_security_group"
  }
}
