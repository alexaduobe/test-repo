terraform {
  required_version = "1.1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.10.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.2"
    }
  }

  backend "s3" {
    region         = "us-east-2"
    bucket         = "dl-aws-mgmt-tfstate-187402594320"
    key            = "base-dns/terraform.tfstate"
    dynamodb_table = "dl-aws-mgmt-tfstate-187402594320-lock"
    encrypt        = "true"
  }
}

provider "aws" {
  profile = var.profile
  region  = "us-east-2"
}

provider "aws" {
  profile = var.profile
  alias   = "use1"
  region  = "us-east-1"
}
