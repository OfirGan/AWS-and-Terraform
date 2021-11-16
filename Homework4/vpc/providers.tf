##################################################################################
# PROVIDERS
##################################################################################

terraform {
  required_version = "1.0.11"

  backend "remote" {
    organization = "OpsSchool-OfirGan"

    workspaces {
      name = "vpc-workspace"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.65.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region_name
}
