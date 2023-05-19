resource "aws_route53_delegation_set" "subdomain" {
  reference_name = local.nameservers_set_name
}

resource "aws_route53_zone" "subdomain" {
  name              = local.audit_root_domain
  comment           = "Daugherty Labs Audit DNS delegated from aws.daughertylabs.io DNS"
  delegation_set_id = aws_route53_delegation_set.subdomain.id
  force_destroy     = true

  tags = merge(module.this.tags, {
    Name = local.audit_root_domain
  })
}

resource "aws_route53_key_signing_key" "subdomain" {
  hosted_zone_id             = aws_route53_zone.subdomain.id
  key_management_service_arn = aws_kms_key.dnssec.arn
  name                       = local.signing_key_name
}

resource "aws_route53_hosted_zone_dnssec" "subdomain" {
  hosted_zone_id = aws_route53_key_signing_key.subdomain.hosted_zone_id
  signing_status = local.signing_status
}
