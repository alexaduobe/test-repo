locals {
  account_id       = data.aws_caller_identity.current.account_id
  kms_key_name     = "${module.this.namespace_full}-controltower"
  prefix_list_name = "${module.this.namespace_full}-dbsvpn"
  tfstate_name     = "${module.this.namespace_full}-tfstate-${local.account_id}"
  artifacts_name   = "${module.this.namespace_full}-artifacts-${local.account_id}"
  artifacts_arn    = "arn:${data.aws_partition.current.partition}:s3:::${local.artifacts_name}"
}
