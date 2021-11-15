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
  profile = "default"
  region  = var.region
}
