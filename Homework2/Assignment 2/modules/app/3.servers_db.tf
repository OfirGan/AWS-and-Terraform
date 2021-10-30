##################################################################################
# DB EC2 INSTANCES
##################################################################################

resource "aws_instance" "db_servers" {
  count             = var.instance_count
  ami               = data.aws_ami.ami_ubuntu_1804_latest.id
  instance_type     = var.instance_type_db
  key_name          = var.key_name
  availability_zone = var.available_zone_names[count.index % length(var.available_zone_names)]

  network_interface {
    network_interface_id = aws_network_interface.db_network_interfaces[count.index].id
    device_index         = 0
  }

  tags = {
    Name    = "${var.purpose_tag}-db-srv-${count.index + 1}"
    Owner   = var.owner_tag
    Purpose = var.purpose_tag
  }
}
