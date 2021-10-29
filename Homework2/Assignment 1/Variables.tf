##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}

variable "region" {
  default = "us-east-1"
}

variable "availability_zones" {
  type = map(string)
  default = {
    "1a" = "us-east-1a"
    "1b" = "us-east-1b"
  }
}

variable "subnet_cidr" {
  type = map(string)
  default = {
    "private-1a" = "10.0.1.0/24"
    "private-1b" = "10.0.2.0/24"
    "public-1a"  = "10.0.3.0/24"
    "public-1b"  = "10.0.4.0/24"
  }
}

variable "instance_type" {
  type = map(string)
  default = {
    "web" = "t2.micro"
    "db"  = "t2.micro"
  }
}

variable "owner_tag" {
  default = "Ofir"
}

variable "purpose_tag" {
  default = "Whiskey"
}
