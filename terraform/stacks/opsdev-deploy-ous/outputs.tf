output "devops_ou_id" {
  description = "ID of the Operations Development organizational unit (OU)."
  value       = aws_organizations_organizational_unit.devops.id
}

output "dep_ou_id" {
  description = "ID of the Deployment organizational unit (OU)."
  value       = aws_organizations_organizational_unit.dep.id
}
