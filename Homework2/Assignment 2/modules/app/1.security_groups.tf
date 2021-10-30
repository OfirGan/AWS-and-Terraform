##################################################################################
# SECURITY_GROUPS
##################################################################################
resource "aws_default_security_group" "default_security_group" {
  vpc_id = var.vpc_id

  tags = {
    "Name" = "${var.purpose_tag}_default_security_group"
  }
}

resource "aws_security_group" "allow_any_http_in_sg" {
  name   = "allow-any-http-in-sg"
  vpc_id = var.vpc_id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  tags = {
    "Name" = "${var.purpose_tag}-allow-any-http-in-sg"
  }
}

resource "aws_security_group" "allow_any_ssh_in_sg" {
  name   = "allow-any-ssh-in-sg"
  vpc_id = var.vpc_id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  tags = {
    "Name" = "${var.purpose_tag}-allow-any-ssh-in-sg"
  }
}

resource "aws_security_group" "allow_any_all_out_sg" {
  name   = "allow-any-all-out-sg"
  vpc_id = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }

  tags = {
    "Name" = "${var.purpose_tag}-allow-any-all-out-sg"
  }
}
