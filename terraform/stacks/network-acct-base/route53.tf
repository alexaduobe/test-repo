resource "aws_route53_delegation_set" "shared" {
  reference_name = local.nameservers_set_name
}

resource "aws_route53_zone" "aws_base" {
  name              = local.aws_root_domain
  comment           = "Daugherty Labs base AWS DNS delegated from external daugherty-labs.com DNS"
  delegation_set_id = aws_route53_delegation_set.shared.id
  force_destroy     = true

  tags = merge(module.this.tags, {
    Name = local.aws_root_domain
  })
}

resource "aws_route53_key_signing_key" "aws_base" {
  hosted_zone_id             = aws_route53_zone.aws_base.id
  key_management_service_arn = aws_kms_key.dnssec.arn
  name                       = local.signing_key_name
}

resource "aws_route53_hosted_zone_dnssec" "aws_base" {
  hosted_zone_id = aws_route53_key_signing_key.aws_base.hosted_zone_id
  signing_status = local.signing_status
}
