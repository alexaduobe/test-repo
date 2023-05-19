resource "aws_organizations_organizational_unit" "devops" {
  name      = "Operations Development"
  parent_id = data.aws_organizations_organization.dl.roots[0].id

  tags = merge(module.this.tags, {
    Name = "dl-aws-devops"
  })
}

resource "aws_organizations_organizational_unit" "dep" {
  name      = "Deployment"
  parent_id = data.aws_organizations_organization.dl.roots[0].id

  tags = merge(module.this.tags, {
    Name = "dl-aws-dep"
  })
}

resource "aws_organizations_account" "devops_test" {
  name                       = "DevOps Pipeline Test"
  email                      = "supportdaughertylabs+devopstest@daugherty.com"
  parent_id                  = aws_organizations_organizational_unit.devops.id
  iam_user_access_to_billing = "ALLOW"
  role_name                  = "AWSControlTowerExecution"

  tags = merge(module.this.tags, {
    Name = "dl-aws-devops-pipelinetest"
  })

  lifecycle {
    ignore_changes = [
      role_name,
    ]
  }
}
