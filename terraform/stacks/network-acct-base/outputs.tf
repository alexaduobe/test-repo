output "route53_delegation_set_id" {
  description = "ID of the shared nameserver delegation set."
  value       = aws_route53_delegation_set.shared.id
}

output "route53_delegation_set_arn" {
  description = "ARN of the shared nameserver delegation set."
  value       = aws_route53_delegation_set.shared.arn
}

output "route53_delegation_set_servers" {
  description = "Shared nameserver delegation set name servers."
  value       = aws_route53_delegation_set.shared.name_servers
}

output "route53_aws_zone_id" {
  description = "ID of the base AWS Route53 zone."
  value       = aws_route53_zone.aws_base.id
}

output "route53_aws_zone_arn" {
  description = "ARN of the base AWS Route53 zone."
  value       = aws_route53_zone.aws_base.arn
}

output "dbsvpn_prefixlist_id" {
  description = "ID of the IP prefix list of Daugherty VPN endpoint IPs."
  value       = module.dbsvpn.datacenter_prefix_list_id
}

output "dbsvpn_prefixlist_arn" {
  description = "ARN of the IP prefix list of Daugherty VPN endpoint IPs."
  value       = module.dbsvpn.datacenter_prefix_list_arn
}
