##################################################################################
# PROVIDERS
##################################################################################

terraform {
  required_version = "1.0.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.63.0"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region_name
}

##################################################################################
# VPC
##################################################################################

module "vpc" {
  source                   = "..\\..\\..\\modules\\vpc\\"
  vpc_name                 = "${var.purpose_tag}_vpc"
  vpc_cidr                 = var.vpc_cidr
  availability_zones_count = 2
}

