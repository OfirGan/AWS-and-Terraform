##################################################################################
# GATEWAYES
##################################################################################


resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.assignment_vpc.id

  tags = {
    Name = "${var.purpose_tag}_internet_gateway"
  }
}


##################################################################################
# 1A NAT GATEWAYES
##################################################################################

resource "aws_eip" "eip_internet_nat_gateway_1a" {

  tags = {
    Name = "${var.purpose_tag}_eip_internet_nat_gateway_1a"
  }

  # EIP may require IGW to exist prior to association. 
  # Use depends_on to set an explicit dependency on the IGW.
  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_nat_gateway" "internet_nat_gateway_1a" {
  allocation_id = aws_eip.eip_internet_nat_gateway_1a.id
  subnet_id     = aws_subnet.public_subnet_1a.id

  tags = {
    Name = "${var.purpose_tag}_internet_nat_gateway_1a"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gateway]
}


##################################################################################
# 1B NAT GATEWAYES
##################################################################################


resource "aws_eip" "eip_internet_nat_gateway_1b" {

  tags = {
    Name = "${var.purpose_tag}_eip_internet_nat_gateway_1b"
  }

  # EIP may require IGW to exist prior to association. 
  # Use depends_on to set an explicit dependency on the IGW.
  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_nat_gateway" "internet_nat_gateway_1b" {
  allocation_id = aws_eip.eip_internet_nat_gateway_1b.id
  subnet_id     = aws_subnet.public_subnet_1b.id

  tags = {
    Name = "${var.purpose_tag}_internet_nat_gateway_1b"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gateway]
}
