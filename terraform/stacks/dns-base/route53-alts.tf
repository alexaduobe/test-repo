resource "aws_route53_zone" "daughertylab_io" {
  name              = local.daughertylab_io_domain
  comment           = "Daugherty Labs alternate base DNS"
  delegation_set_id = aws_route53_delegation_set.shared.id
  force_destroy     = true

  tags = merge(module.this.tags, {
    Name = local.daughertylab_io_domain
  })
}

resource "aws_route53_zone" "daughertylab_com" {
  name              = local.daughertylab_com_domain
  comment           = "Daugherty Labs alternate base DNS"
  delegation_set_id = aws_route53_delegation_set.shared.id
  force_destroy     = true

  tags = merge(module.this.tags, {
    Name = local.daughertylab_com_domain
  })
}

resource "aws_route53_zone" "daugherty_labs_com" {
  name              = local.daugherty_labs_com_domain
  comment           = "Daugherty Labs alternate base DNS"
  delegation_set_id = aws_route53_delegation_set.shared.id
  force_destroy     = true

  tags = merge(module.this.tags, {
    Name = local.daugherty_labs_com_domain
  })
}

resource "aws_route53_record" "daughertylab_io" {
  name    = local.daughertylab_io_domain
  type    = "A"
  zone_id = aws_route53_zone.daughertylab_io.zone_id
  alias {
    evaluate_target_health = false
    name                   = aws_s3_bucket.daughertylab_io.website_domain
    zone_id                = aws_s3_bucket.daughertylab_io.hosted_zone_id
  }
}

resource "aws_route53_record" "www_daughertylab_io" {
  name    = "www.${local.daughertylab_io_domain}"
  type    = "A"
  zone_id = aws_route53_zone.daughertylab_io.zone_id
  alias {
    evaluate_target_health = false
    name                   = aws_s3_bucket.www_daughertylab_io.website_domain
    zone_id                = aws_s3_bucket.www_daughertylab_io.hosted_zone_id
  }
}

resource "aws_route53_record" "daughertylab_com" {
  name    = local.daughertylab_com_domain
  type    = "A"
  zone_id = aws_route53_zone.daughertylab_com.zone_id
  alias {
    evaluate_target_health = false
    name                   = aws_s3_bucket.daughertylab_com.website_domain
    zone_id                = aws_s3_bucket.daughertylab_com.hosted_zone_id
  }
}

resource "aws_route53_record" "www_daughertylab_com" {
  name    = "www.${local.daughertylab_com_domain}"
  type    = "A"
  zone_id = aws_route53_zone.daughertylab_com.zone_id
  alias {
    evaluate_target_health = false
    name                   = aws_s3_bucket.www_daughertylab_com.website_domain
    zone_id                = aws_s3_bucket.www_daughertylab_com.hosted_zone_id
  }
}

resource "aws_route53_record" "daugherty_labs_com" {
  name    = local.daugherty_labs_com_domain
  type    = "A"
  zone_id = aws_route53_zone.daugherty_labs_com.zone_id
  alias {
    evaluate_target_health = false
    name                   = aws_s3_bucket.daugherty_labs_com.website_domain
    zone_id                = aws_s3_bucket.daugherty_labs_com.hosted_zone_id
  }
}

resource "aws_route53_record" "www_daugherty_labs_com" {
  name    = "www.${local.daugherty_labs_com_domain}"
  type    = "A"
  zone_id = aws_route53_zone.daugherty_labs_com.zone_id
  alias {
    evaluate_target_health = false
    name                   = aws_s3_bucket.www_daugherty_labs_com.website_domain
    zone_id                = aws_s3_bucket.www_daugherty_labs_com.hosted_zone_id
  }
}
