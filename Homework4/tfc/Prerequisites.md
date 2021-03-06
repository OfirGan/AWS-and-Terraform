# Prerequisites

## Terraform Cloud
* Organization Name (need to be created)
* VCS Provider OAuth Token ID (need connect organization to github)

---

## GitHub
* Organization Name
* Workspaces:
    * Workspaces Repository Name
    * VPC Workspace - VCS Repo Workinkg Directory (/working/dir)
    * EC2 Workspace - VCS Repo Workinkg Directory (/working/dir)
* Modules:
    * VPC Module Repository Name (path/to/module)
    * EC2 Module Repository Name (path/to/module)

---

## AWS
* AWS Acess Key (need to be created)
* AWS Secret Acess Key (need to be created)
* Region Name
* Create EC2 Key Pair (need to be created)

---

## Slack
*  slack notification webhook url (need to be created)

---

## terraform.tfvars File
create terraform.tfvars using this template:
```
##################################################################################
# Terraform Cloud
##################################################################################
tfe_organization_name           = "<Terraform Cloud Organization Name>"
tfe_vcs_provider_oauth_token_id = "ot-XXXXXXXXXX"

##################################################################################
# Github
##################################################################################
vcs_organization_name        = "<Github UserName>"
vcs_workspace_repo_name      = "<Workspace Repo Name>"
vpc_workspace_repo_directory = "/working/dir"
ec2_workspace_repo_directory = "/working/dir"
vpc_aws_module_github_path   = "terraform-aws-vpc"
ec2_aws_module_github_path   = "terraform-aws-ec2"

##################################################################################
# AWS
##################################################################################
aws_acess_key_id     = "XXXXXX"
aws_secret_acess_key = "XXXXXX"
aws_default_region   = "us-east-1"

owner_tag  = "Owner"
purpose_tag = "Purpose"

##################################################################################
# AWS VPC
##################################################################################
vpc_cidr                 = "10.0.0.0/16"
availability_zones_count = 2

##################################################################################
# AWS EC2
##################################################################################
aws_ec2_key_pair_name = "key-pair-name"
instance_count        = 2
instance_type         = "t2.micro"
s3_logs_bucket_name   = "bucket-name"
s3_logs_folder        = "hw4"

##################################################################################
# Slack
##################################################################################
notification_triggers          = ["run:completed"]
slack_notification_webhook_url = "https://hooks.slack.com/services/...."
```