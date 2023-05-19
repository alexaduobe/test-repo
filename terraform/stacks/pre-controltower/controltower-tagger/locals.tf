locals {
  account_id      = data.aws_caller_identity.current.account_id
  function_name   = "${var.name_prefix}-cttagger"
  event_rule_name = "${var.name_prefix}-cttagger"
  artifact_tags = {
    dbs-confidentiality = lookup(var.tags, "dbs-confidentiality", "confidential")
    dbs-codeowners      = lookup(var.tags, "dbs-codeowners", "N/A")
    dbs-dataowners      = lookup(var.tags, "dbs-dataowners", "N/A")
    dbs-deletiondate    = lookup(var.tags, "dbs-deletiondate", "N/A")
    dbs-dataregulations = lookup(var.tags, "dbs-dataregulations", "N/A")
    dbs-privacyreview   = lookup(var.tags, "dbs-privacyreview", "N/A")
    dbs-securityreview  = lookup(var.tags, "dbs-securityreview", "N/A")
  }
}
