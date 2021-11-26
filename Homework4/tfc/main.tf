##################################################################################
# Organization
##################################################################################

resource "tfe_organization" "organization" {
  name  = var.tfe_organization_name
  email = var.tfe_organization_email
}

##################################################################################
# OAuth Token
##################################################################################

resource "tfe_oauth_client" "github_oauth_token" {
  organization     = "my-org-name"
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.vcs_personal_access_token
  service_provider = "github"
}

##################################################################################
# TFE Registry Module
##################################################################################

resource "tfe_registry_module" "vpc_tfe_module" {
  vcs_repo {
    display_identifier = "${var.vcs_organization_name}/${var.vpc_tfe_module_github_path}"
    identifier         = "${var.vcs_organization_name}/${var.vpc_tfe_module_github_path}"
    oauth_token_id     = resource.tfe_oauth_client.github_oauth_token.tfe_oauth_token_id
  }
}

resource "tfe_registry_module" "ec2_tfe_module" {
  vcs_repo {
    display_identifier = "${var.vcs_organization_name}/${var.ec2_tfe_module_github_path}"
    identifier         = "${var.vcs_organization_name}/${var.ec2_tfe_module_github_path}"
    oauth_token_id     = resource.tfe_oauth_client.github_oauth_token.tfe_oauth_token_id
  }
}

##################################################################################
# Workspace
##################################################################################

module "vpc_tfe_module" {
  source                    = "app.terraform.io/OpsSchool-OfirGan/vpc/tfe"
  oauth_token_id            = resource.tfe_oauth_client.github_oauth_token.tfe_oauth_token_id
  remote_state_consumer_ids = [module.ec2_tfe_module.workspace_id]
  aws_acess_key_id          = var.aws_acess_key_id
  aws_secret_acess_key      = var.aws_secret_acess_key
  aws_default_region        = var.aws_default_region

  vpc_cidr                 = var.vpc_cidr
  availability_zones_count = var.availability_zones_count

  purpose_tag = var.purpose_tag
}

module "ec2_tfe_module" {
  source         = "app.terraform.io/OpsSchool-OfirGan/ec2/tfe"
  oauth_token_id = resource.tfe_oauth_client.github_oauth_token.tfe_oauth_token_id

  aws_acess_key_id     = var.aws_acess_key_id
  aws_secret_acess_key = var.aws_secret_acess_key
  aws_default_region   = var.aws_default_region

  aws_ec2_key_pair_name = var.aws_ec2_key_pair_name
  instance_count        = var.instance_count
  instance_type         = var.instance_type
  s3_logs_bucket_name   = var.s3_logs_bucket_name
  s3_logs_folder        = var.s3_logs_folder

  owner_tag   = var.owner_tag
  purpose_tag = var.purpose_tag
}


##################################################################################
# Workspace Triggers
##################################################################################

resource "tfe_run_trigger" "ec2_auto_run_after_vpc" {
  workspace_id  = module.ec2_tfe_module.workspace_id
  sourceable_id = module.vpc_tfe_module.workspace_id
}
