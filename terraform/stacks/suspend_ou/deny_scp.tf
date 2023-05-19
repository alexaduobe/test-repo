data "aws_iam_policy_document" "deny_all_access" {
  statement {
    sid       = "DenyAllAccess"
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_organizations_policy" "deny_account_access_scp" {
  name        = "dl-aws-susp-deny-access-scp"
  description = "SCP to restrict access of all the actions for account being deleted, generated for Suspended OU"
  content     = data.aws_iam_policy_document.deny_all_access.json

  tags = merge(module.this.tags, {
    Name = "dl-aws-deny-access-scp"
  })
}

resource "aws_organizations_policy_attachment" "deny_account_access_scp_attach" {
  policy_id = aws_organizations_policy.deny_account_access_scp.id
  target_id = aws_organizations_organizational_unit.suspended_ou.id
}
