terraform {
  required_version = "1.1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.69.0"
    }
  }

  backend "s3" {
    region         = "us-east-2"
    bucket         = "dl-aws-mgmt-tfstate-187402594320"
    key            = "public-ecr/terraform.tfstate"
    dynamodb_table = "dl-aws-mgmt-tfstate-187402594320-lock"
    encrypt        = "true"
  }
}

provider "aws" {
  profile = var.profile
  region  = "us-east-1"
}
