##################################################################################
# WEB NETWORK INTERFACES
##################################################################################

resource "aws_network_interface" "web_network_interfaces" {
  count           = var.instance_count
  subnet_id       = var.public_subnets_ids[count.index % length(var.public_subnets_ids)]
  security_groups = [aws_security_group.allow_any_http_in_sg.id, aws_security_group.allow_any_ssh_in_sg.id, aws_security_group.allow_any_all_out_sg.id]

  tags = {
    Name = "${var.purpose_tag}-network-interface-web-${count.index + 1}"
  }
}

##################################################################################
# WEB EC2 INSTANCES
##################################################################################

resource "aws_instance" "nginx_web_servers" {
  count                = var.instance_count
  ami                  = data.aws_ami.ami_ubuntu_1804_latest.id
  instance_type        = var.instance_type_web
  key_name             = var.key_name
  availability_zone    = var.available_zone_names[count.index % length(var.available_zone_names)]
  user_data            = local.nginx-webserver
  iam_instance_profile = aws_iam_instance_profile.web_instance_profile.id

  network_interface {
    network_interface_id = aws_network_interface.web_network_interfaces[count.index].id
    device_index         = 0
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)
  }

  tags = {
    Name    = "${var.purpose_tag}-web-srv-${count.index + 1}"
    Owner   = var.owner_tag
    Purpose = var.purpose_tag
  }
}
