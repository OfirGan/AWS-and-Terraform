##################################################################################
# DB EC2 INSTANCES
##################################################################################

resource "aws_instance" "db_srv_1a" {
  ami               = data.aws_ami.ami_ubuntu_1804_latest.id
  instance_type     = var.instance_type["db"]
  key_name          = var.key_name
  availability_zone = var.availability_zones["1a"]

  network_interface {
    network_interface_id = aws_network_interface.network_interface_db_1a.id
    device_index         = 0
  }

  tags = {
    Name    = "${var.purpose_tag}_db_srv_1a"
    Owner   = var.owner_tag
    Purpose = var.purpose_tag
  }
}

resource "aws_instance" "db_srv_1b" {
  ami               = data.aws_ami.ami_ubuntu_1804_latest.id
  instance_type     = var.instance_type["db"]
  key_name          = var.key_name
  availability_zone = var.availability_zones["1b"]

  network_interface {
    network_interface_id = aws_network_interface.network_interface_db_1b.id
    device_index         = 0
  }

  tags = {
    Name    = "${var.purpose_tag}_db_srv_1b"
    Owner   = var.owner_tag
    Purpose = var.purpose_tag
  }
}
