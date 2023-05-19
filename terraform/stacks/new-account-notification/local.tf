locals {
  sns_name    = module.this.name_prefix
  lambda_name = "${module.this.name_prefix}-lambdarole"

}