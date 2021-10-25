##################################################################################
# WEB EC2 INSTANCES
##################################################################################

resource "aws_instance" "nginx_web_srv_1a" {
  ami               = data.aws_ami.ami_ubuntu_1804_latest.id
  instance_type     = var.instance_type["web"]
  key_name          = var.key_name
  availability_zone = var.availability_zones["1a"]
  user_data         = local.nginx-webserver

  network_interface {
    network_interface_id = aws_network_interface.network_interface_web_1a.id
    device_index         = 0
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)
  }

  tags = {
    Name    = "${var.purpose_tag}_nginx_web_srv_1a"
    Owner   = var.owner_tag
    Purpose = var.purpose_tag
  }
}

resource "aws_instance" "nginx_web_srv_1b" {
  ami               = data.aws_ami.ami_ubuntu_1804_latest.id
  instance_type     = var.instance_type["web"]
  key_name          = var.key_name
  availability_zone = var.availability_zones["1b"]
  user_data         = local.nginx-webserver

  network_interface {
    network_interface_id = aws_network_interface.network_interface_web_1b.id
    device_index         = 0
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)
  }

  tags = {
    Name    = "${var.purpose_tag}_nginx_web_srv_1b"
    Owner   = var.owner_tag
    Purpose = var.purpose_tag
  }
}
