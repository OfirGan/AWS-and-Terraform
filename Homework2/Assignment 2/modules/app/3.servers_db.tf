##################################################################################
# DB NETWORK INTERFACES
##################################################################################

resource "aws_network_interface" "db_network_interfaces" {
  count     = var.instance_count
  subnet_id = var.private_subnets_ids[count.index % length(var.private_subnets_ids)]
  # To Allow SSH Connection Through Bastion Host add -> , aws_security_group.allow_any_ssh_in_sg.id
  security_groups = [aws_security_group.allow_any_all_out_sg.id]

  tags = {
    Name = "${var.purpose_tag}-network-interface-db-${count.index + 1}"
  }
}

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
