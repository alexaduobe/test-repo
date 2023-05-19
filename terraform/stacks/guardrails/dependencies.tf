data "aws_organizations_organization" "dl" {}

data "aws_organizations_organizational_units" "dl" {
  parent_id = data.aws_organizations_organization.dl.roots[0].id
}
