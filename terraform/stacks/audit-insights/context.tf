module "this" {
  source = "git::git@bitbucket.org:DBSDEVMAN/terraform-local-dbscontext.git?ref=v0.3.0"

  enabled         = true
  organization    = "dl"
  cloud_provider  = "aws"
  namespace       = "grc"
  name            = "audit"
  environment     = "production"
  project_owners  = ["daughertylabs@daugherty.com"]
  project         = "N/A"
  project_type    = "N/A"
  code_owners     = ["daughertylabs@daugherty.com"]
  data_owners     = ["daughertylabs@daugherty.com"]
  availability    = "preemptable"
  deployer        = "Terraform"
  confidentiality = "confidential"
}
