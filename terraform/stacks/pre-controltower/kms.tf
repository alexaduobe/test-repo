data "aws_iam_policy_document" "controltower_kms" {
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
    sid = "Allow CloudTrail and AWS Config to encrypt/decrypt logs"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com", "config.amazonaws.com"]
    }
    actions   = ["kms:GenerateDataKey", "kms:Decrypt"]
    resources = ["*"]
  }
}

resource "aws_kms_key" "controltower" {
  description              = "Control Tower resources key"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.controltower_kms.json
  deletion_window_in_days  = 30
  enable_key_rotation      = true

  tags = merge(module.this.tags, {
    Name = local.kms_key_name
  })
}

resource "aws_kms_alias" "controltower" {
  name          = "alias/${local.kms_key_name}"
  target_key_id = aws_kms_key.controltower.key_id
}
