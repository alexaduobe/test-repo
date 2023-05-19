module "control_tower_account_factory" {
  source  = "aws-ia/control_tower_account_factory/aws"
  version = "1.6.7"

  # Accounts
  ct_management_account_id  = var.ct_management_account_id
  log_archive_account_id    = var.log_archive_account_id
  audit_account_id          = var.audit_account_id
  aft_management_account_id = var.aft_management_account_id
  # General
  ct_home_region                    = var.region
  maximum_concurrent_customizations = 2
  cloudwatch_log_group_retention    = "14"
  # Terraform
  terraform_version           = "1.3.4"
  terraform_distribution      = "oss"
  tf_backend_secondary_region = var.region_secondary
  # Feature Flags
  aft_feature_cloudtrail_data_events      = true
  aft_feature_delete_default_vpcs_enabled = true
  aft_feature_enterprise_support          = false
  # VPC
  aft_vpc_cidr                   = "10.192.0.0/22"
  aft_vpc_private_subnet_01_cidr = "10.192.0.0/24"
  aft_vpc_private_subnet_02_cidr = "10.192.1.0/24"
  aft_vpc_public_subnet_01_cidr  = "10.192.2.0/25"
  aft_vpc_public_subnet_02_cidr  = "10.192.2.128/25"
  aft_vpc_endpoints              = false
  # VCS
  vcs_provider                                    = "bitbucket"
  account_request_repo_name                       = "DBSDEVMAN/dl-aws-aft-accounts"
  account_request_repo_branch                     = "develop"
  global_customizations_repo_name                 = "DBSDEVMAN/dl-aws-aft-global-customize"
  global_customizations_repo_branch               = "develop"
  account_customizations_repo_name                = "DBSDEVMAN/dl-aws-aft-acct-customize"
  account_customizations_repo_branch              = "develop"
  account_provisioning_customizations_repo_name   = "DBSDEVMAN/dl-aws-aft-acct-provisioning"
  account_provisioning_customizations_repo_branch = "develop"
}
