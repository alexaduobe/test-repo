data "aws_iam_policy_document" "artifacts" {
  statement {
    sid    = "Allow loading of Lambda executables"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["serverlessrepo.amazonaws.com"]
    }
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${local.artifacts_arn}/*",
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
      "${local.artifacts_arn}/*",
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
      "${local.artifacts_arn}/*",
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
      "${local.artifacts_arn}",
      "${local.artifacts_arn}/*",
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_s3_bucket" "artifacts" {
  bucket        = local.artifacts_name
  acl           = "private"
  force_destroy = false
  policy        = data.aws_iam_policy_document.artifacts.json

  versioning {
    enabled    = true
    mfa_delete = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = merge(module.this.tags, {
    Name = local.artifacts_name
  })
}

resource "aws_s3_bucket_public_access_block" "artifacts" {
  bucket                  = aws_s3_bucket.artifacts.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}
