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

variable "availability_zone" {
  type = map(string)
  default = {
    "private" = "us-east-1a"
    "public"  = "us-east-1b"
  }
}

variable "subnet_cidr" {
  type = map(string)
  default = {
    "private" = "10.0.1.0/24"
    "public"  = "10.0.2.0/24"
  }
}

variable "instance_type" {
  type = map(string)
  default = {
    "web" = "t2.micro"
    "db"  = "t2.micro"
  }
}

variable "instance_count" {
  type = map(number)
  default = {
    "web" = 2
    "db"  = 2
  }
}

variable "server_name_tag" {
  type = map(string)
  default = {
    "web" = "nginx_web_srv"
    "db"  = "db_srv"
  }
}

variable "owner_tag" {
  default = "Ofir"
}

variable "purpose_tag" {
  default = "Whiskey"
}
