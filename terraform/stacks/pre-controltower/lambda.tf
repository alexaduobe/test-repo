module "ct_tagger" {
  source             = "./controltower-tagger"
  enabled            = true
  name_prefix        = module.this.namespace_full
  artifact_s3_bucket = aws_s3_bucket.artifacts.bucket
  tags               = module.this.tags
}

module "resource_postct_security" {
  source                     = "./post-ct-security"
  enabled                    = true
  name_prefix                = module.this.namespace_full
  artifact_s3_bucket         = aws_s3_bucket.artifacts.bucket
  region                     = var.region
  governed_regions           = "us-east-2,us-east-1,us-west-2,eu-west-1,ap-southeast-2"
  administrator_account_name = "Audit"
  tags                       = module.this.tags
}
