resource "aws_ram_resource_share" "dbsvpn" {
  name                      = local.prefix_list_name
  allow_external_principals = true

  tags = merge(module.this.tags, {
    Name = local.prefix_list_name
  })
}

resource "aws_ram_resource_association" "dbsvpn" {
  resource_arn       = module.dbsvpn.datacenter_prefix_list_arn
  resource_share_arn = aws_ram_resource_share.dbsvpn.arn
}

resource "aws_ram_principal_association" "dbsvpn" {
  principal          = data.aws_organizations_organization.dl.arn
  resource_share_arn = aws_ram_resource_share.dbsvpn.arn
}
