locals {
  account_id           = data.aws_caller_identity.current.account_id
  partition            = data.aws_partition.current.partition
  prefix_list_name     = "${module.this.namespace_full}-dbsvpn"
  nameservers_set_name = "dl-aws-dns"
  aws_root_domain      = "aws.daughertylabs.io"
  www_aws_root_domain  = "www.${local.aws_root_domain}"
  alternative_domains = [
    local.aws_root_domain,
    local.www_aws_root_domain,
  ]
  kms_key_name     = "${module.this.namespace_full}-dnssec"
  signing_key_name = "${local.kms_key_name}-ksk"
  signing_status   = var.enable_dnssec ? "SIGNING" : "NOT_SIGNING"
  logs_bucket_name = "${module.baseaws.name_prefix}-accesslogs"
  deployment_roles = [
    "arn:${local.partition}:iam::${local.account_id}:role/AWSAFTExecution",
    "arn:${local.partition}:iam::${local.account_id}:role/AWSControlTowerExecution",
  ]
  deployment_principal_arns = { for r in local.deployment_roles : r => [""] }
  artifact_tags = {
    dbs-confidentiality = lookup(module.baseaws.tags, "dbs-confidentiality", "confidential")
    dbs-codeowners      = lookup(module.baseaws.tags, "dbs-codeowners", "N/A")
    dbs-dataowners      = lookup(module.baseaws.tags, "dbs-dataowners", "N/A")
    dbs-deletiondate    = lookup(module.baseaws.tags, "dbs-deletiondate", "N/A")
    dbs-dataregulations = lookup(module.baseaws.tags, "dbs-dataregulations", "N/A")
    dbs-privacyreview   = lookup(module.baseaws.tags, "dbs-privacyreview", "N/A")
    dbs-securityreview  = lookup(module.baseaws.tags, "dbs-securityreview", "N/A")
  }
}
