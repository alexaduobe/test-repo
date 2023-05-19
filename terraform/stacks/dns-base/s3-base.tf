resource "aws_s3_bucket" "daughertylabs_io" {
  bucket        = local.dl_root_domain
  force_destroy = true

  tags = merge(module.this.tags, {
    Name = local.dl_root_domain
  })
}

resource "aws_s3_bucket_website_configuration" "daughertylabs_io" {
  bucket = aws_s3_bucket.daughertylabs_io.bucket
  redirect_all_requests_to {
    host_name = local.tmp_website_domain
    protocol  = "https"
  }
}

resource "aws_s3_bucket_acl" "daughertylabs_io" {
  bucket = aws_s3_bucket.daughertylabs_io.bucket
  acl    = "public-read"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "daughertylabs_io" {
  bucket = aws_s3_bucket.daughertylabs_io.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

data "aws_iam_policy_document" "daughertylabs_io" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [local.account_id]
    }
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.daughertylabs_io.arn,
      "${aws_s3_bucket.daughertylabs_io.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "daughertylabs_io" {
  bucket = aws_s3_bucket.daughertylabs_io.bucket
  policy = data.aws_iam_policy_document.daughertylabs_io.json
}

resource "aws_s3_bucket" "www_daughertylabs_io" {
  bucket        = "www.${local.dl_root_domain}"
  force_destroy = true

  tags = merge(module.this.tags, {
    Name = "www.${local.dl_root_domain}"
  })
}

resource "aws_s3_bucket_website_configuration" "www_daughertylabs_io" {
  bucket = aws_s3_bucket.www_daughertylabs_io.bucket
  redirect_all_requests_to {
    host_name = local.tmp_website_domain
    protocol  = "https"
  }
}

resource "aws_s3_bucket_acl" "www_daughertylabs_io" {
  bucket = aws_s3_bucket.www_daughertylabs_io.bucket
  acl    = "public-read"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "www_daughertylabs_io" {
  bucket = aws_s3_bucket.www_daughertylabs_io.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

data "aws_iam_policy_document" "www_daughertylabs_io" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [local.account_id]
    }
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.www_daughertylabs_io.arn,
      "${aws_s3_bucket.www_daughertylabs_io.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "www_daughertylabs_io" {
  bucket = aws_s3_bucket.www_daughertylabs_io.bucket
  policy = data.aws_iam_policy_document.www_daughertylabs_io.json
}
