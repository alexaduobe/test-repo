resource "aws_s3_bucket" "daughertylab_io" {
  bucket        = local.daughertylab_io_domain
  force_destroy = true

  tags = merge(module.this.tags, {
    Name = local.daughertylab_io_domain
  })
}

resource "aws_s3_bucket_website_configuration" "daughertylab_io" {
  bucket = aws_s3_bucket.daughertylab_io.bucket
  redirect_all_requests_to {
    host_name = local.tmp_website_domain
    protocol  = "https"
  }
}

resource "aws_s3_bucket_acl" "daughertylab_io" {
  bucket = aws_s3_bucket.daughertylab_io.bucket
  acl    = "public-read"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "daughertylab_io" {
  bucket = aws_s3_bucket.daughertylab_io.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

data "aws_iam_policy_document" "daughertylab_io" {
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
      aws_s3_bucket.daughertylab_io.arn,
      "${aws_s3_bucket.daughertylab_io.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "daughertylab_io" {
  bucket = aws_s3_bucket.daughertylab_io.bucket
  policy = data.aws_iam_policy_document.daughertylab_io.json
}

resource "aws_s3_bucket" "www_daughertylab_io" {
  bucket        = "www.${local.daughertylab_io_domain}"
  force_destroy = true

  tags = merge(module.this.tags, {
    Name = "www.${local.daughertylab_io_domain}"
  })
}

resource "aws_s3_bucket_website_configuration" "www_daughertylab_io" {
  bucket = aws_s3_bucket.www_daughertylab_io.bucket
  redirect_all_requests_to {
    host_name = local.tmp_website_domain
    protocol  = "https"
  }
}

resource "aws_s3_bucket_acl" "www_daughertylab_io" {
  bucket = aws_s3_bucket.www_daughertylab_io.bucket
  acl    = "public-read"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "www_daughertylab_io" {
  bucket = aws_s3_bucket.www_daughertylab_io.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

data "aws_iam_policy_document" "www_daughertylab_io" {
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
      aws_s3_bucket.www_daughertylab_io.arn,
      "${aws_s3_bucket.www_daughertylab_io.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "www_daughertylab_io" {
  bucket = aws_s3_bucket.www_daughertylab_io.bucket
  policy = data.aws_iam_policy_document.www_daughertylab_io.json
}

resource "aws_s3_bucket" "daughertylab_com" {
  bucket        = local.daughertylab_com_domain
  force_destroy = true

  tags = merge(module.this.tags, {
    Name = local.daughertylab_com_domain
  })
}

resource "aws_s3_bucket_website_configuration" "daughertylab_com" {
  bucket = aws_s3_bucket.daughertylab_com.bucket
  redirect_all_requests_to {
    host_name = local.tmp_website_domain
    protocol  = "https"
  }
}

resource "aws_s3_bucket_acl" "daughertylab_com" {
  bucket = aws_s3_bucket.daughertylab_com.bucket
  acl    = "public-read"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "daughertylab_com" {
  bucket = aws_s3_bucket.daughertylab_com.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

data "aws_iam_policy_document" "daughertylab_com" {
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
      aws_s3_bucket.daughertylab_com.arn,
      "${aws_s3_bucket.daughertylab_com.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "daughertylab_com" {
  bucket = aws_s3_bucket.daughertylab_com.bucket
  policy = data.aws_iam_policy_document.daughertylab_com.json
}

resource "aws_s3_bucket" "www_daughertylab_com" {
  bucket        = "www.${local.daughertylab_com_domain}"
  force_destroy = true

  tags = merge(module.this.tags, {
    Name = "www.${local.daughertylab_com_domain}"
  })
}

resource "aws_s3_bucket_website_configuration" "www_daughertylab_com" {
  bucket = aws_s3_bucket.www_daughertylab_com.bucket
  redirect_all_requests_to {
    host_name = local.tmp_website_domain
    protocol  = "https"
  }
}

resource "aws_s3_bucket_acl" "www_daughertylab_com" {
  bucket = aws_s3_bucket.www_daughertylab_com.bucket
  acl    = "public-read"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "www_daughertylab_com" {
  bucket = aws_s3_bucket.www_daughertylab_com.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

data "aws_iam_policy_document" "www_daughertylab_com" {
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
      aws_s3_bucket.www_daughertylab_com.arn,
      "${aws_s3_bucket.www_daughertylab_com.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "www_daughertylab_com" {
  bucket = aws_s3_bucket.www_daughertylab_com.bucket
  policy = data.aws_iam_policy_document.www_daughertylab_com.json
}

resource "aws_s3_bucket" "daugherty_labs_com" {
  bucket        = local.daugherty_labs_com_domain
  force_destroy = true

  tags = merge(module.this.tags, {
    Name = local.daugherty_labs_com_domain
  })
}

resource "aws_s3_bucket_website_configuration" "daugherty_labs_com" {
  bucket = aws_s3_bucket.daugherty_labs_com.bucket
  redirect_all_requests_to {
    host_name = local.tmp_website_domain
    protocol  = "https"
  }
}

resource "aws_s3_bucket_acl" "daugherty_labs_com" {
  bucket = aws_s3_bucket.daugherty_labs_com.bucket
  acl    = "public-read"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "daugherty_labs_com" {
  bucket = aws_s3_bucket.daugherty_labs_com.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

data "aws_iam_policy_document" "daugherty_labs_com" {
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
      aws_s3_bucket.daugherty_labs_com.arn,
      "${aws_s3_bucket.daugherty_labs_com.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "daugherty_labs_com" {
  bucket = aws_s3_bucket.daugherty_labs_com.bucket
  policy = data.aws_iam_policy_document.daugherty_labs_com.json
}

resource "aws_s3_bucket" "www_daugherty_labs_com" {
  bucket        = "www.${local.daugherty_labs_com_domain}"
  force_destroy = true

  tags = merge(module.this.tags, {
    Name = "www.${local.daugherty_labs_com_domain}"
  })
}

resource "aws_s3_bucket_website_configuration" "www_daugherty_labs_com" {
  bucket = aws_s3_bucket.www_daugherty_labs_com.bucket
  redirect_all_requests_to {
    host_name = local.tmp_website_domain
    protocol  = "https"
  }
}

resource "aws_s3_bucket_acl" "www_daugherty_labs_com" {
  bucket = aws_s3_bucket.www_daugherty_labs_com.bucket
  acl    = "public-read"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "www_daugherty_labs_com" {
  bucket = aws_s3_bucket.www_daugherty_labs_com.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

data "aws_iam_policy_document" "www_daugherty_labs_com" {
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
      aws_s3_bucket.www_daugherty_labs_com.arn,
      "${aws_s3_bucket.www_daugherty_labs_com.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "www_daugherty_labs_com" {
  bucket = aws_s3_bucket.www_daugherty_labs_com.bucket
  policy = data.aws_iam_policy_document.www_daugherty_labs_com.json
}
