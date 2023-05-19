data "aws_iam_policy_document" "athena_queries" {
  statement {
    sid    = "Allow loading by Lambda"
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "athena.${local.dns_suffix}",
      ]
    }
    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]
    resources = [
      "${local.queries_arn}/*",
    ]
    condition {
      test     = "StringEquals"
      values   = ["${local.account_id}"]
      variable = "aws:SourceAccount"
    }
  }

  statement {
    sid    = "DenyIncorrectEncryptionHeader"
    effect = "Deny"
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "${local.queries_arn}/*",
    ]
    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values = [
        "AES256",
        "aws:kms"
      ]
    }
  }

  statement {
    sid    = "DenyUnEncryptedObjectUploads"
    effect = "Deny"
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "${local.queries_arn}/*",
    ]
    condition {
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"
      values = [
        "true"
      ]
    }
  }

  statement {
    sid    = "EnforceTlsRequestsOnly"
    effect = "Deny"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = ["s3:*"]
    resources = [
      "${local.queries_arn}",
      "${local.queries_arn}/*",
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_s3_bucket" "athena_queries" {
  bucket        = local.queries_name
  acl           = "private"
  force_destroy = false
  policy        = data.aws_iam_policy_document.athena_queries.json

  versioning {
    enabled    = true
    mfa_delete = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.s3_kms_key.arn
      }
      bucket_key_enabled = true
    }
  }

  tags = merge(module.this.tags, {
    Name = local.queries_name
  })
}

resource "aws_s3_bucket_public_access_block" "athena_queries" {
  bucket                  = aws_s3_bucket.athena_queries.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}
