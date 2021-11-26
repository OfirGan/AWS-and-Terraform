##################################################################################
# Terraform Cloud
##################################################################################

variable "tfe_organization_name" {
  description = "Terraform Cloud Organization Name"
  type        = string
}

variable "tfe_organization_email" {
  description = "Terraform Cloud Organization Name"
  type        = string
}

##################################################################################
# Github
##################################################################################

variable "vcs_organization_name" {
  description = "VCS Organization Name"
  type        = string
}

variable "vcs_workspace_repo_name" {
  description = "Workspaces VCS Repo Name"
  type        = string
}

variable "vpc_workspace_repo_directory" {
  description = "VPC Workspace - VCS Repo Workinkg Directory"
  type        = string
}

variable "ec2_workspace_repo_directory" {
  description = "EC2 Workspace - VCS Repo Workinkg Directory "
  type        = string
}

variable "vpc_tfe_module_github_path" {
  description = "github vpc-tfe module path path/to/module"
  type        = string
}

variable "ec2_tfe_module_github_path" {
  description = "github ec2-tfe module path path/to/module"
  type        = string
}

variable "vpc_aws_module_github_path" {
  description = "github vpc-aws module path path/to/module"
  type        = string
}

variable "ec2_aws_module_github_path" {
  description = "github ec2-aws module path path/to/module"
  type        = string
}

##################################################################################
# AWS Global
##################################################################################

variable "aws_acess_key_id" {
  description = "AWS Acess Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_acess_key" {
  description = "AWS Secret Acess Key"
  type        = string
  sensitive   = true
}

variable "aws_default_region" {
  description = "AWS Default Region"
  type        = string
}

##################################################################################
# AWS VPC
##################################################################################

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "availability_zones_count" {
  description = "AZ Count to create subnets in"
  type        = number
}

variable "purpose_tag" {
  description = "Purpose Tag Name"
  type        = string
}

##################################################################################
# AWS EC2
##################################################################################

variable "aws_ec2_key_pair_name" {
  type = string
}

variable "instance_count" {
  description = "Web & DB servers Pairs Count"
  type        = number
}

variable "instance_type" {
  type = string
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


##################################################################################
# Slack
##################################################################################

variable "slack_notification_webhook_url" {
  description = "Slack Notification Webhook URL"
  type        = string
  sensitive   = true
}

variable "notification_triggers" {
  # Options: https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/notification_configuration#triggers
  description = "Slack Notification Webhook URL"
  type        = list(string)
}
