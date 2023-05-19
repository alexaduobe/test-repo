output "datacenter_prefix_list_id" {
  description = "ID of the created managed prefix list."
  value       = aws_ec2_managed_prefix_list.dbs_dc.id
}

output "datacenter_prefix_list_arn" {
  description = "ARN of the created managed prefix list."
  value       = aws_ec2_managed_prefix_list.dbs_dc.arn
}
