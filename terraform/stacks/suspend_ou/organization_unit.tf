resource "aws_organizations_organizational_unit" "suspended_ou" {
  name      = "Suspended"
  parent_id = data.aws_organizations_organization.dl.roots[0].id

  tags = merge(module.this.tags, {
    Name = "dl-aws-susp"
  })
}

 