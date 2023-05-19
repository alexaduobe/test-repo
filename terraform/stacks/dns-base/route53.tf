resource "aws_route53_delegation_set" "shared" {
  reference_name = local.nameservers_set_name
}

resource "aws_route53_zone" "daughertylabs_io" {
  name              = local.dl_root_domain
  comment           = "Daugherty Labs primary base DNS"
  delegation_set_id = aws_route53_delegation_set.shared.id
  force_destroy     = false

  tags = merge(module.this.tags, {
    Name = local.dl_root_domain
  })
}

resource "aws_route53_key_signing_key" "daughertylabs_io" {
  hosted_zone_id             = aws_route53_zone.daughertylabs_io.id
  key_management_service_arn = aws_kms_key.dnssec_daughertylabs_io.arn
  name                       = local.signing_key_name
}

resource "aws_route53_hosted_zone_dnssec" "daughertylabs_io" {
  hosted_zone_id = aws_route53_key_signing_key.daughertylabs_io.hosted_zone_id
  signing_status = local.signing_status
}

resource "aws_route53_record" "daughertylabs_io" {
  name    = local.dl_root_domain
  type    = "A"
  zone_id = aws_route53_zone.daughertylabs_io.zone_id
  alias {
    evaluate_target_health = false
    name                   = aws_s3_bucket.daughertylabs_io.website_domain
    zone_id                = aws_s3_bucket.daughertylabs_io.hosted_zone_id
  }
}

resource "aws_route53_record" "www_daughertylabs_io" {
  name    = "www.${local.dl_root_domain}"
  type    = "A"
  zone_id = aws_route53_zone.daughertylabs_io.zone_id
  alias {
    evaluate_target_health = false
    name                   = aws_s3_bucket.www_daughertylabs_io.website_domain
    zone_id                = aws_s3_bucket.www_daughertylabs_io.hosted_zone_id
  }
}

resource "aws_route53_record" "aws_daughertylabs_io" {
  name    = "aws.${local.dl_root_domain}"
  type    = "NS"
  zone_id = aws_route53_zone.daughertylabs_io.zone_id
  ttl     = 86400
  records = local.inf_net_delegation_set
}
