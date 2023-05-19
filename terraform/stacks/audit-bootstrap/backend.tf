terraform {
  required_version = "1.1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }

  backend "s3" {
    region         = "us-east-2"
    bucket         = "dl-aws-grc-tfstate-358557491831"
    key            = "audit-bootstrap/terraform.tfstate"
    dynamodb_table = "dl-aws-grc-tfstate-358557491831-lock"
    encrypt        = "true"
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

provider "aws" {
  profile = var.profile
  alias   = "use1"
  region  = "us-east-1"
}
