terraform {
  required_version = "1.1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
  }

  backend "s3" {
    region         = "us-east-2"
    bucket         = "dl-aws-grc-tfstate-358557491831"
    key            = "audit-insights/terraform.tfstate"
    dynamodb_table = "dl-aws-grc-tfstate-358557491831-lock"
    encrypt        = "true"
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}
