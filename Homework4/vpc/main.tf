##################################################################################
# VPC
##################################################################################

module "vpc" {
  source                   = "app.terraform.io/OpsSchool-OfirGan/vpc/aws"
  version                  = "0.2.0-alpha"
  purpose_tag              = var.purpose_tag
  vpc_cidr                 = var.vpc_cidr
  availability_zones_count = var.availability_zones_count
}
