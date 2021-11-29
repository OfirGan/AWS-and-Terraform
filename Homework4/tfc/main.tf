##################################################################################
# Organization
##################################################################################

data "tfe_organization" "organization" {
  name = var.tfe_organization_name
}

##################################################################################
# Slack Notification
##################################################################################

resource "tfe_notification_configuration" "slack_notification" {
  count            = 2
  name             = "Slack Notification"
  enabled          = true
  destination_type = "slack"
  triggers         = var.notification_triggers
  url              = var.slack_notification_webhook_url
  workspace_id     = count.index == 0 ? resource.tfe_workspace.ec2_workspace.id : resource.tfe_workspace.vpc_workspace.id
}


##################################################################################
# Global Workspace Environment Variables
##################################################################################

resource "tfe_variable" "aws_access_key_id" {
  count        = 2
  key          = "AWS_ACCESS_KEY_ID"
  value        = var.aws_acess_key_id
  category     = "env"
  sensitive    = "true"
  workspace_id = count.index == 0 ? resource.tfe_workspace.ec2_workspace.id : resource.tfe_workspace.vpc_workspace.id
  description  = "AWS Connection"
}

resource "tfe_variable" "aws_secret_acess_key" {
  count        = 2
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = var.aws_secret_acess_key
  category     = "env"
  sensitive    = "true"
  workspace_id = count.index == 0 ? resource.tfe_workspace.ec2_workspace.id : resource.tfe_workspace.vpc_workspace.id
  description  = "AWS Connection"
}

resource "tfe_variable" "aws_default_region" {
  count        = 2
  key          = "AWS_DEFAULT_REGION"
  value        = var.aws_default_region
  description  = "AWS Default Region"
  workspace_id = count.index == 0 ? resource.tfe_workspace.ec2_workspace.id : resource.tfe_workspace.vpc_workspace.id
  category     = "env"
}

##################################################################################
# Global Workspace Environment Variables
##################################################################################

resource "tfe_variable" "purpose_tag" {
  count        = 2
  key          = "purpose_tag"
  value        = var.purpose_tag
  description  = "Purpose Tag Name"
  workspace_id = count.index == 0 ? resource.tfe_workspace.ec2_workspace.id : resource.tfe_workspace.vpc_workspace.id
  category     = "terraform"
}

##################################################################################
# Workspace Triggers
##################################################################################

resource "tfe_run_trigger" "ec2_auto_run_after_vpc" {
  workspace_id  = resource.tfe_workspace.ec2_workspace.id
  sourceable_id = resource.tfe_workspace.vpc_workspace.id
}
