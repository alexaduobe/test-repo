resource "aws_organizations_organizational_unit" "workloads" {
  name      = "Workloads"
  parent_id = data.aws_organizations_organization.dl.roots[0].id

  tags = merge(module.this.tags, {
    Name = "dl-aws-wl"
  })
}

resource "aws_organizations_organizational_unit" "prod_workloads" {
  name      = "Production Workloads"
  parent_id = aws_organizations_organizational_unit.workloads.id

  tags = merge(module.this.tags, {
    Name = "dl-aws-wlprod"
  })
}

resource "aws_organizations_organizational_unit" "nonprod_workloads" {
  name      = "Non-Prod Workloads"
  parent_id = aws_organizations_organizational_unit.workloads.id

  tags = merge(module.this.tags, {
    Name = "dl-aws-wlnp"
  })
}
