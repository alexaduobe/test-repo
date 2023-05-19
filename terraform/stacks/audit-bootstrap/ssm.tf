resource "aws_ssm_parameter" "dbs_org" {
  name  = "/dbs/naming/organization"
  type  = "String"
  value = module.this.normalized_context["organization"]

  tags = module.this.tags
}

resource "aws_ssm_parameter" "dbs_namespace" {
  name  = "/dbs/naming/namespace"
  type  = "String"
  value = module.this.normalized_context["namespace"]

  tags = module.this.tags
}

resource "aws_ssm_parameter" "dbs_env" {
  name  = "/dbs/naming/environment"
  type  = "String"
  value = module.this.normalized_context["environment"]

  tags = module.this.tags
}

resource "aws_ssm_parameter" "dbs_account" {
  name  = "/dbs/naming/accountname"
  type  = "String"
  value = module.this.namespace_full

  tags = module.this.tags
}

resource "aws_ssm_parameter" "dbs_display" {
  name  = "/dbs/naming/displayname"
  type  = "String"
  value = "Audit"

  tags = module.this.tags
}

resource "aws_ssm_parameter" "dbs_projectowners" {
  name  = "/dbs/tagging/projectowners"
  type  = "String"
  value = module.this.tags["dbs-projectowners"]

  tags = module.this.tags
}

resource "aws_ssm_parameter" "dbs_project" {
  name  = "/dbs/tagging/project"
  type  = "String"
  value = module.this.tags["dbs-project"]

  tags = module.this.tags
}

resource "aws_ssm_parameter" "dbs_projecttype" {
  name  = "/dbs/tagging/projecttype"
  type  = "String"
  value = module.this.tags["dbs-projecttype"]

  tags = module.this.tags
}

resource "aws_ssm_parameter" "dbs_codeowners" {
  name  = "/dbs/tagging/codeowners"
  type  = "String"
  value = module.this.tags["dbs-codeowners"]

  tags = module.this.tags
}

resource "aws_ssm_parameter" "dbs_dataowners" {
  name  = "/dbs/tagging/dataowners"
  type  = "String"
  value = module.this.tags["dbs-dataowners"]

  tags = module.this.tags
}

resource "aws_ssm_parameter" "dbs_environment" {
  name  = "/dbs/tagging/environment"
  type  = "String"
  value = module.this.tags["dbs-environment"]

  tags = module.this.tags
}

resource "aws_ssm_parameter" "dbs_availability" {
  name  = "/dbs/tagging/availability"
  type  = "String"
  value = module.this.tags["dbs-availability"]

  tags = module.this.tags
}
