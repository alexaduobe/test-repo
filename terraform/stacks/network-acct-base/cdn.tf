module "cloudfront_s3_cdn" {
  source  = "cloudposse/cloudfront-s3-cdn/aws"
  version = "0.82.3"

  enabled     = true
  namespace   = ""
  environment = ""
  stage       = ""
  name        = module.baseaws.name_prefix

  parent_zone_id      = aws_route53_zone.aws_base.zone_id
  dns_alias_enabled   = true
  aliases             = local.alternative_domains
  acm_certificate_arn = aws_acm_certificate.base.arn

  cors_allowed_headers = ["*"]
  cors_allowed_methods = ["GET", "HEAD"]
  cors_allowed_origins = ["*.daugherty.com"]
  cors_expose_headers  = ["ETag"]
  cors_max_age_seconds = 3600

  price_class = "PriceClass_100"

  deployment_principal_arns          = local.deployment_principal_arns
  block_origin_public_access_enabled = true
  origin_force_destroy               = true

  s3_access_logging_enabled           = false
  cloudfront_access_logging_enabled   = true
  cloudfront_access_log_create_bucket = true
  cloudfront_access_log_prefix        = "logs/cf_access"

  custom_origins = []
  s3_origins     = []
  origin_groups  = []

  lambda_function_association = []
  forward_header_values       = []

  tags = module.baseaws.tags

  providers = {
    aws = aws.use1
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket       = module.cloudfront_s3_cdn.s3_bucket
  key          = "index.html"
  source       = "${path.module}/../../../sites/aws-static/index.html"
  content_type = "text/html"
  etag         = md5(file("${path.module}/../../../sites/aws-static/index.html"))

  tags = local.artifact_tags

  provider = aws.use1
}
