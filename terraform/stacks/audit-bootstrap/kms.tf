data "aws_iam_policy_document" "dnssec_key" {
  statement {
    sid = "Enable IAM policies"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
  statement {
    sid    = "Allow Route 53 DNSSEC Service"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["dnssec-route53.amazonaws.com"]
    }
    actions = [
      "kms:DescribeKey",
      "kms:GetPublicKey",
      "kms:Sign",
    ]
    resources = ["*"]
  }
  statement {
    sid    = "Allow Route 53 DNSSEC Service to CreateGrant"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["dnssec-route53.amazonaws.com"]
    }
    actions = [
      "kms:CreateGrant",
    ]
    resources = ["*"]
    condition {
      test     = "Bool"
      values   = ["true"]
      variable = "kms:GrantIsForAWSResource"
    }
  }

  provider = aws.use1
}

resource "aws_kms_key" "dnssec" {
  description              = "DNSSEC signing key"
  key_usage                = "SIGN_VERIFY"
  customer_master_key_spec = "ECC_NIST_P256"
  policy                   = data.aws_iam_policy_document.dnssec_key.json
  deletion_window_in_days  = 30
  enable_key_rotation      = false

  tags = merge(module.this.tags, {
    Name = local.kms_key_name
  })

  provider = aws.use1
}

resource "aws_kms_alias" "dnssec" {
  name          = "alias/${local.kms_key_name}"
  target_key_id = aws_kms_key.dnssec.key_id

  provider = aws.use1
}
