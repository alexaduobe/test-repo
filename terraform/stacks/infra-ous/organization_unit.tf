resource "aws_organizations_organizational_unit" "infrastructure" {
  name      = "Infrastructure"
  parent_id = data.aws_organizations_organization.daugherty_labs.roots[0].id

  tags = merge(module.this.tags, {
    Name = "dl-aws-inf"
  })
}
