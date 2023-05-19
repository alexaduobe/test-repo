locals {
  account_id   = data.aws_caller_identity.current.account_id
  dns_suffix   = data.aws_partition.current.dns_suffix
  ctlogs_name  = "${module.this.name_prefix}-ctlogssource"
  ctlogs_arn   = "arn:${data.aws_partition.current.partition}:s3:::${local.ctlogs_name}"
  queries_name = "${module.this.name_prefix}-queryresults"
  queries_arn  = "arn:${data.aws_partition.current.partition}:s3:::${local.queries_name}"
  s3_kms_name  = "${module.this.name_prefix}-s3ct"

  principal_arn           = "arn:aws:quicksight:us-east-1:358557491831"
  datasource_id           = "logarchivedatasource"
  dataset_id_accounts     = "logarchivetopstenaccounts"
  dataset_id_api_requests = "logarchivetotalapirequests"
  dataset_id_services     = "logarchivetopstenservices"
  dataset_id_users        = "logarchivetopstenusers"
}
