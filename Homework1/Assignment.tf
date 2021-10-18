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
variable "instance_type" {
  default = "t3.micro"
}

variable "instance_count" {
  default = 2
}

variable "server_name_tag" {
  default = "nginx_web_srv"
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

resource "aws_security_group" "nginx_web_server_security_group" {
  name   = "nginx_web_server_security_group"
  vpc_id = aws_default_vpc.default.id

  # Allow All HTTP Inbound
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  # Allow All SSH Inbound
  ingress { # Allow SSH Inbound
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # Allow All Any Outbound
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }
}

resource "aws_instance" "nginx_web_srv" {
  count                  = var.instance_count
  ami                    = data.aws_ami.ami_ubuntu_1804_latest.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  availability_zone      = var.availability_zone
  vpc_security_group_ids = [aws_security_group.nginx_web_server_security_group.id]

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
      "sudo chmod 777 /var/www/html/index.nginx-debian.html",
      "sudo echo \"Welcome to Grandpa's Whiskey\" > /var/www/html/index.nginx-debian.html",
      "sudo service nginx start"
    ]
  }

  tags = {
    Name    = "${var.server_name_tag}-${count.index + 1}"
    Owner   = var.owner_tag
    Purpose = var.purpose_tag
  }
}

# Create encrypted EBS Volume
resource "aws_ebs_volume" "ebs_vols" {
  count             = var.instance_count
  availability_zone = var.availability_zone
  size              = 10
  encrypted         = true
  type              = "gp2"

  tags = {
    Name    = "${var.server_name_tag}-${count.index + 1}-ebs-volume"
    Owner   = var.owner_tag
    Purpose = var.purpose_tag
  }
}

# Assign each EBS Volume to an EC2 instance
resource "aws_volume_attachment" "attach_ebs_vols" {
  count       = var.instance_count
  device_name = "/dev/sdh"
  volume_id   = element(aws_ebs_volume.ebs_vols.*.id, count.index)
  instance_id = element(aws_instance.nginx_web_srv.*.id, count.index)
}

##################################################################################
# OUTPUT
##################################################################################

output "aws_instance_public_dns" {
  value = aws_instance.nginx_web_srv.*.public_dns
}
