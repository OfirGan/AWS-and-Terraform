##################################################################################
# VPC
##################################################################################

resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "${var.purpose_tag}-vpc"
  }
}
