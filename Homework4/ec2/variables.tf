##################################################################################
# VARIABLES
##################################################################################

variable "aws_ec2_key_pair_name" {
  type = string
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "s3_logs_bucket_name" {
  type = string
}

variable "s3_logs_folder" {
  type = string
}


variable "owner_tag" {
  type = string
}

variable "purpose_tag" {
  type = string
}
