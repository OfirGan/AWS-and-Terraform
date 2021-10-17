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
  default = "us-east-1a"
}

#variable "instance_count" {
#  default = 2
#}

variable "server_name_tag" {
  default = "nginx_webserver"
}

variable "owner_tag" {
  default = "Ofir"
}

variable "purpose_tag" {
  default = "Whiskey"
}

##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}


##################################################################################
# DATA
##################################################################################

data "aws_ami" "ami_ubuntu_1804_latest" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server*"]
  }
}


##################################################################################
# RESOURCES
##################################################################################

#This uses the default VPC.  It WILL NOT delete it on destroy.
resource "aws_default_vpc" "default" {

}

# Allow HTTP Inbound
resource "aws_security_group" "allow_http_any_inbound" {
  name   = "allow_http_any_inbound"
  vpc_id = aws_default_vpc.default.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
}

# Allow SSH Inbound
resource "aws_security_group" "allow_ssh_any_inbound" {
  name   = "allow_ssh_any_inbound"
  vpc_id = aws_default_vpc.default.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
}

# Allow Any Outbound
resource "aws_security_group" "allow_any_outbound" {
  name   = "allow_any_outbound"
  vpc_id = aws_default_vpc.default.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx_web" {
  ami                    = data.aws_ami.ami_ubuntu_1804_latest.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  availability_zone      = var.availability_zone
  vpc_security_group_ids = [aws_security_group.allow_http_any_inbound.id, aws_security_group.allow_ssh_any_inbound.id, aws_security_group.allow_any_outbound.id]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)

  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
      "sudo service nginx start"
    ]

  }

  tags = {
    Name    = var.server_name_tag
    Owner   = var.owner_tag
    Purpose = var.purpose_tag
  }
}

##################################################################################
# OUTPUT
##################################################################################

output "aws_instance_public_dns" {
  value = aws_instance.nginx_web.public_dns
}
