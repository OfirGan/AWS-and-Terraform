##################################################################################
# Registry Module
##################################################################################

resource "tfe_registry_module" "ec2" {
  vcs_repo {
    display_identifier = "${var.vcs_organization_name}/${var.ec2_aws_module_github_path}"
    identifier         = "${var.vcs_organization_name}/${var.ec2_aws_module_github_path}"
    oauth_token_id     = var.tfe_vcs_provider_oauth_token_id
  }
}


##################################################################################
# Workspace
##################################################################################

resource "tfe_workspace" "ec2_workspace" {
  name              = "ec2-workspace"
  organization      = var.tfe_organization_name
  auto_apply        = "false"
  execution_mode    = "remote"
  working_directory = var.ec2_workspace_repo_directory

  vcs_repo {
    identifier     = "${var.vcs_organization_name}/${var.vcs_workspace_repo_name}"
    oauth_token_id = var.tfe_vcs_provider_oauth_token_id
  }

  depends_on = [
    resource.tfe_registry_module.ec2
  ]
}

##################################################################################
# Workspace Variables
##################################################################################

resource "tfe_variable" "aws_ec2_key_pair_name" {
  key          = "aws_ec2_key_pair_name"
  value        = var.aws_ec2_key_pair_name
  description  = "Web & DB aws public key name"
  workspace_id = resource.tfe_workspace.ec2_workspace.id
  category     = "terraform"
}

resource "tfe_variable" "instance_count" {
  key          = "instance_count"
  value        = var.instance_count
  description  = "Web & DB servers Pairs Count"
  workspace_id = resource.tfe_workspace.ec2_workspace.id
  category     = "terraform"
}

resource "tfe_variable" "instance_type" {
  key          = "instance_type"
  value        = var.instance_type
  description  = "Web & DB server Type"
  workspace_id = resource.tfe_workspace.ec2_workspace.id
  category     = "terraform"
}

resource "tfe_variable" "s3_logs_bucket_name" {
  key          = "s3_logs_bucket_name"
  value        = var.s3_logs_bucket_name
  description  = "S3 Logs Bucket Name"
  workspace_id = resource.tfe_workspace.ec2_workspace.id
  category     = "terraform"
}

resource "tfe_variable" "s3_logs_folder" {
  key          = "s3_logs_folder"
  value        = var.s3_logs_folder
  description  = "S3 Logs Folder"
  workspace_id = resource.tfe_workspace.ec2_workspace.id
  category     = "terraform"
}

resource "tfe_variable" "owner_tag" {
  key          = "owner_tag"
  value        = var.owner_tag
  description  = "Owner Name"
  workspace_id = resource.tfe_workspace.ec2_workspace.id
  category     = "terraform"
}
