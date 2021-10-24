##################################################################################
# AMI
##################################################################################

data "aws_ami" "ami_ubuntu_1804_latest" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server*"]
  }
}

##################################################################################
# EC2_NETWORK_INTERFACES
##################################################################################

resource "aws_network_interface" "public_network_interface" {
  count           = var.instance_count["web"]
  subnet_id       = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.nginx_web_security_group.id]
  tags = {
    Name = "public_network_interface"
  }
}

resource "aws_network_interface" "private_network_interface" {
  count           = var.instance_count["db"]
  subnet_id       = aws_subnet.private_subnet.id
  security_groups = [aws_security_group.db_security_group.id]
  tags = {
    Name = "private_network_interface"
  }
}

##################################################################################
# EC2_INSTANCES
##################################################################################

resource "aws_instance" "nginx_web_srv" {
  count             = var.instance_count["web"]
  ami               = data.aws_ami.ami_ubuntu_1804_latest.id
  instance_type     = var.instance_type["web"]
  key_name          = var.key_name
  availability_zone = var.availability_zone["public"]
  user_data         = local.nginx-webserver

  network_interface {
    network_interface_id = aws_network_interface.public_network_interface[count.index].id
    device_index         = 0
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)
  }

  tags = {
    Name    = "${var.purpose_tag}_${var.server_name_tag["web"]}_${count.index + 1}"
    Owner   = var.owner_tag
    Purpose = var.purpose_tag
  }
}

resource "aws_instance" "db_srv" {
  count             = var.instance_count["db"]
  ami               = data.aws_ami.ami_ubuntu_1804_latest.id
  instance_type     = var.instance_type["db"]
  key_name          = var.key_name
  availability_zone = var.availability_zone["private"]

  network_interface {
    network_interface_id = aws_network_interface.private_network_interface[count.index].id
    device_index         = 0
  }

  connection {
    type        = "ssh"
    host        = self.private_ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)
  }

  tags = {
    Name    = "${var.purpose_tag}_${var.server_name_tag["db"]}_${count.index + 1}"
    Owner   = var.owner_tag
    Purpose = var.purpose_tag
  }
}
