##################################################################################
# EC2
##################################################################################

module "ec2" {
  source               = "app.terraform.io/OpsSchool-OfirGan/ec2/aws"
  version              = "0.1.0-alpha"
  vpc_id               = module.vpc.vpc_id
  available_zone_names = module.vpc.available_zone_names
  s3_logs_bucket_name  = var.s3_logs_bucket_name
  s3_logs_folder       = var.s3_logs_folder
  public_subnets_ids   = module.vpc.public_subnets_ids
  private_subnets_ids  = module.vpc.private_subnets_ids
  instance_count       = var.instance_count
  instance_type_web    = var.instance_type["web"]
  instance_type_db     = var.instance_type["db"]
  purpose_tag          = var.purpose_tag
  owner_tag            = var.owner_tag
}
