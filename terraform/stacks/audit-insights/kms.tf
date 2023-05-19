data "aws_iam_policy_document" "s3_kms_key" {
  statement {
    sid = "Enable IAM policies"
    principals {
      type        = "AWS"
      identifiers = ["arn:${data.aws_partition.current.partition}:iam::${local.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
  statement {
    sid    = "Allow S3 Encryption"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:${data.aws_partition.current.partition}:iam::${local.account_id}:root"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "kms:ViaService"
      values   = ["s3.*.${local.dns_suffix}"]
    }
  }
  statement {
    sid    = "Lambda"
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "lambda.${local.dns_suffix}",
        "glue.${local.dns_suffix}",
        "athena.${local.dns_suffix}",
      ]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = ["*"]
  }
}

resource "aws_kms_key" "s3_kms_key" {
  description              = "CMK for encrypting S3 CloudTrail and Athena data"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.aws_iam_policy_document.s3_kms_key.json
  deletion_window_in_days  = 14
  enable_key_rotation      = true

  tags = merge(module.this.tags, {
    Name = local.s3_kms_name
  })
}

resource "aws_kms_alias" "s3_kms_key" {
  name          = "alias/${local.s3_kms_name}"
  target_key_id = aws_kms_key.s3_kms_key.key_id
}
