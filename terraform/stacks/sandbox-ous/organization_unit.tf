resource "aws_organizations_organizational_unit" "dl_aws_sbpoc" {
  name      = "Proof-of-Concept Sandboxes"
  parent_id = local.sandbox_ou[0].id

  tags = merge(module.this.tags, {
    Name = "dl-aws-sbpoc"
  })
}

resource "aws_organizations_organizational_unit" "dl_aws_sbtrng" {
  name      = "Training Sandboxes"
  parent_id = local.sandbox_ou[0].id

  tags = merge(module.this.tags, {
    Name = "dl-aws-sbtrng"
  })
}
