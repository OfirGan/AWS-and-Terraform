##################################################################################
# Registry Module
##################################################################################

resource "tfe_registry_module" "vpc" {
  vcs_repo {
    display_identifier = "${var.vcs_organization_name}/${var.vpc_aws_module_github_path}"
    identifier         = "${var.vcs_organization_name}/${var.vpc_aws_module_github_path}"
    oauth_token_id     = var.tfe_vcs_provider_oauth_token_id
  }
}


##################################################################################
# Workspace
##################################################################################

resource "tfe_workspace" "vpc_workspace" {
  name                      = "vpc-workspace"
  organization              = var.tfe_organization_name
  auto_apply                = "false"
  execution_mode            = "remote"
  working_directory         = var.vpc_workspace_repo_directory
  remote_state_consumer_ids = [resource.tfe_workspace.ec2_workspace.id]

  vcs_repo {
    identifier     = "${var.vcs_organization_name}/${var.vcs_workspace_repo_name}"
    oauth_token_id = var.tfe_vcs_provider_oauth_token_id
  }

  depends_on = [
    resource.tfe_registry_module.vpc
  ]
}

##################################################################################
# Workspace Variables
##################################################################################

resource "tfe_variable" "vpc_cidr" {
  key          = "vpc_cidr"
  value        = var.vpc_cidr
  description  = "VPC CIDR"
  workspace_id = resource.tfe_workspace.vpc_workspace.id
  category     = "terraform"
}

resource "tfe_variable" "availability_zones_count" {
  key          = "availability_zones_count"
  value        = var.availability_zones_count
  description  = "AZ Count to create subnets in"
  workspace_id = resource.tfe_workspace.vpc_workspace.id
  category     = "terraform"
}

