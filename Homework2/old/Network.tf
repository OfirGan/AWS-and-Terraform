# ##################################################################################
# # VPC
# ##################################################################################

# resource "aws_vpc" "assignment_vpc" {
#   cidr_block       = "10.0.0.0/16"
#   instance_tenancy = "default"

#   tags = {
#     Name = "${var.purpose_tag}_vpc"
#   }
# }

# resource "aws_default_route_table" "default_route_table" {
#   default_route_table_id = aws_vpc.assignment_vpc.default_route_table_id

#   tags = {
#     Name = "${var.purpose_tag}_default_route_table"
#   }
# }

##################################################################################
# GATEWAYES
##################################################################################

# resource "aws_internet_gateway" "internet_gateway" {
#   vpc_id = aws_vpc.assignment_vpc.id

#   tags = {
#     Name = "${var.purpose_tag}_internet_gateway"
#   }
# }

# resource "aws_eip" "eip_internet_nat_gateway" {

#   tags = {
#     Name = "${var.purpose_tag}_eip_internet_nat_gateway"
#   }

#   # EIP may require IGW to exist prior to association. 
#   # Use depends_on to set an explicit dependency on the IGW.
#   depends_on = [aws_internet_gateway.internet_gateway]
# }

# resource "aws_nat_gateway" "internet_nat_gateway" {
#   allocation_id = aws_eip.eip_internet_nat_gateway.id
#   subnet_id     = aws_subnet.public_subnet.id

#   tags = {
#     Name = "${var.purpose_tag}_internet_nat_gateway"
#   }

#   # To ensure proper ordering, it is recommended to add an explicit dependency
#   # on the Internet Gateway for the VPC.
#   depends_on = [aws_internet_gateway.internet_gateway]
# }

##################################################################################
# PUBLIC SUBNET
##################################################################################

# resource "aws_subnet" "public_subnet" {
#   vpc_id                  = aws_vpc.assignment_vpc.id
#   cidr_block              = var.subnet_cidr["public"]
#   availability_zone       = var.availability_zone["public"]
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "${var.purpose_tag}_public_subnet"
#   }
# }

# resource "aws_route_table" "public_route_table" {
#   vpc_id = aws_vpc.assignment_vpc.id

#   tags = {
#     Name = "${var.purpose_tag}_public_route_table"
#   }
# }

# resource "aws_route" "route_to_internet_gateway" {
#   route_table_id         = aws_route_table.public_route_table.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.internet_gateway.id
# }

# resource "aws_route_table_association" "public_route_table_association" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_route_table.id
# }


##################################################################################
# PRIVATE SUBNET
##################################################################################


# resource "aws_subnet" "private_subnet" {
#   vpc_id            = aws_vpc.assignment_vpc.id
#   cidr_block        = var.subnet_cidr["private"]
#   availability_zone = var.availability_zone["private"]

#   tags = {
#     Name = "${var.purpose_tag}_private_subnet"
#   }
# }

# resource "aws_route_table" "private_route_table" {
#   vpc_id = aws_vpc.assignment_vpc.id

#   tags = {
#     Name = "${var.purpose_tag}_private_route_table"
#   }
# }

# resource "aws_route" "route_to_internet_nat_gateway" {
#   route_table_id         = aws_route_table.private_route_table.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_nat_gateway.internet_nat_gateway.id
# }

# resource "aws_route_table_association" "private_route_table_association" {
#   subnet_id      = aws_subnet.private_subnet.id
#   route_table_id = aws_route_table.private_route_table.id
# }
