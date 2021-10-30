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
# DB NETWORK INTERFACES
##################################################################################

resource "aws_network_interface" "db_network_interfaces" {
  count           = var.instance_count
  subnet_id       = var.private_subnets_ids[count.index % length(var.private_subnets_ids)]
  security_groups = [aws_security_group.allow_any_all_out_sg.id]

  tags = {
    Name = "${var.purpose_tag}-network-interface-db-${count.index + 1}"
  }
}
