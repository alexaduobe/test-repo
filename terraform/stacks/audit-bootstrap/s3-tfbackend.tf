module "terraform_state_backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "0.38.1"

  name       = local.tfstate_name
  attributes = []
  tags       = module.this.tags

  terraform_backend_config_file_path = "./.terraform"
  terraform_backend_config_file_name = "s3-backend.tf"
  force_destroy                      = false
}
