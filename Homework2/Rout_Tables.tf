##################################################################################
# Rout Tables
##################################################################################

resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.assignment_vpc.default_route_table_id

  tags = {
    Name = "${var.purpose_tag}_default_route_table"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.assignment_vpc.id

  tags = {
    Name = "${var.purpose_tag}_public_route_table"
  }
}

resource "aws_route" "route_to_internet_gateway" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}


##################################################################################
# 1A Rout Tables
##################################################################################

resource "aws_route_table_association" "public_route_table_association_1a" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table_1a" {
  vpc_id = aws_vpc.assignment_vpc.id

  tags = {
    Name = "${var.purpose_tag}_private_route_table_1a"
  }
}

resource "aws_route" "route_to_internet_nat_gateway_1a" {
  route_table_id         = aws_route_table.private_route_table_1a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.internet_nat_gateway_1a.id
}

resource "aws_route_table_association" "private_route_table_association_1a" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.private_route_table_1a.id
}


##################################################################################
# 1B Rout Tables
##################################################################################

resource "aws_route_table_association" "public_route_table_association_1b" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table" "private_route_table_1b" {
  vpc_id = aws_vpc.assignment_vpc.id

  tags = {
    Name = "${var.purpose_tag}_private_route_table_1b"
  }
}

resource "aws_route" "route_to_internet_nat_gateway_1b" {
  route_table_id         = aws_route_table.private_route_table_1b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.internet_nat_gateway_1b.id
}

resource "aws_route_table_association" "private_route_table_association_1b" {
  subnet_id      = aws_subnet.private_subnet_1b.id
  route_table_id = aws_route_table.private_route_table_1b.id
}
