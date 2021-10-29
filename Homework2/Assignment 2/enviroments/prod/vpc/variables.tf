##################################################################################
# VARIABLES
##################################################################################
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}


variable "region_name" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "instance_type" {
  type = map(string)
  default = {
    "web" = "t2.micro"
    "db"  = "t2.micro"
  }
}

variable "owner_tag" {
  type    = string
  default = "Ofir"
}

variable "purpose_tag" {
  type    = string
  default = "Whiskey"
}
