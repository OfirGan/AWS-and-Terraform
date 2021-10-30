##################################################################################
# WEB NETWORK INTERFACES
##################################################################################

resource "aws_network_interface" "network_interface_web_1a" {
  subnet_id       = aws_subnet.public_subnet_1a.id
  security_groups = [aws_security_group.nginx_web_security_group.id]

  tags = {
    Name = "${var.purpose_tag}_network_interface_web_1a"
  }
}

resource "aws_network_interface" "network_interface_web_1b" {
  subnet_id       = aws_subnet.public_subnet_1b.id
  security_groups = [aws_security_group.nginx_web_security_group.id]

  tags = {
    Name = "${var.purpose_tag}_network_interface_web_1b"
  }
}


##################################################################################
# DB NETWORK INTERFACES
##################################################################################

resource "aws_network_interface" "network_interface_db_1a" {
  subnet_id       = aws_subnet.private_subnet_1a.id
  security_groups = [aws_security_group.db_security_group.id]
  tags = {
    Name = "${var.purpose_tag}_network_interface_db_1a"
  }
}

resource "aws_network_interface" "network_interface_db_1b" {
  subnet_id       = aws_subnet.private_subnet_1b.id
  security_groups = [aws_security_group.db_security_group.id]
  tags = {
    Name = "${var.purpose_tag}_network_interface_1b"
  }
}
