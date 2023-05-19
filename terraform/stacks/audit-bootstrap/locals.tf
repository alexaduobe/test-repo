locals {
  account_id     = data.aws_caller_identity.current.account_id
  tfstate_name   = "${module.this.namespace_full}-tfstate-${local.account_id}"
  artifacts_name = "${module.this.namespace_full}-artifacts-${local.account_id}"
  artifacts_arn  = "arn:${data.aws_partition.current.partition}:s3:::${local.artifacts_name}"
  infcicd_name   = "${module.this.name_prefix}-infcicd"

  infrastructure_repo_uuids = [
    "{d3ec415f-acf5-4e2b-b1ec-69c6474ea5d9}",
    "{f77d99b4-6c09-43c4-8a8a-7b8c5c1f578c}",
    "{f645f200-6467-40b0-8a62-cfb4087837e3}",
  ]

  nameservers_set_name = "dl-aws-grc"
  audit_root_domain    = "audit.aws.daughertylabs.io"
  kms_key_name         = "${module.this.namespace_full}-dnssec"
  signing_key_name     = "${local.kms_key_name}-ksk"
  signing_status       = var.enable_dnssec ? "SIGNING" : "NOT_SIGNING"
}
