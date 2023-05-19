resource "aws_acm_certificate" "base" {
  domain_name               = local.aws_root_domain
  validation_method         = "DNS"
  subject_alternative_names = local.alternative_domains

  tags = merge(module.baseaws.tags, {
    Name = local.aws_root_domain
  })

  depends_on = [aws_route53_zone.aws_base]

  lifecycle {
    create_before_destroy = true
  }

  provider = aws.use1
}

resource "aws_route53_record" "cert_validate" {
  for_each = {
    for dvo in aws_acm_certificate.base.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.aws_base.zone_id

  provider = aws.use1
}

resource "aws_acm_certificate_validation" "acct_wildcard" {
  certificate_arn         = aws_acm_certificate.base.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validate : record.fqdn]

  provider = aws.use1
}
