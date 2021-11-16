##################################################################################
# PROVIDERS
##################################################################################

terraform {
  required_version = "1.0.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.63.0"
    }
  }

  backend "s3" {
    bucket = "ofirgan-ops-bucket"
    key    = "hw3/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  profile = "default"
  region  = var.region_name
}
