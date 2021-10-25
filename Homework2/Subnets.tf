##################################################################################
# 1A Subnets
##################################################################################


resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.assignment_vpc.id
  cidr_block              = var.subnet_cidr["public-1a"]
  availability_zone       = var.availability_zones["1a"]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.purpose_tag}_public_subnet_1a"
  }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id            = aws_vpc.assignment_vpc.id
  cidr_block        = var.subnet_cidr["private-1a"]
  availability_zone = var.availability_zones["1a"]

  tags = {
    Name = "${var.purpose_tag}_private_subnet_1a"
  }
}


##################################################################################
# 1B Subnets
##################################################################################


resource "aws_subnet" "public_subnet_1b" {
  vpc_id                  = aws_vpc.assignment_vpc.id
  cidr_block              = var.subnet_cidr["public-1b"]
  availability_zone       = var.availability_zones["1b"]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.purpose_tag}_public_subnet_1b"
  }
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id            = aws_vpc.assignment_vpc.id
  cidr_block        = var.subnet_cidr["private-1b"]
  availability_zone = var.availability_zones["1b"]

  tags = {
    Name = "${var.purpose_tag}_private_subnet_1b"
  }
}
