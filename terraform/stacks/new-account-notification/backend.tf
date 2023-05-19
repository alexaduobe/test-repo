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
    bucket         = "dl-aws-devops-tfstate-187390017608"
    key            = "aftnotification/terraform.tfstate"
    dynamodb_table = "dl-aws-devops-tfstate-187390017608-lock"
    encrypt        = "true"

  }


}

provider "aws" {
  profile = var.profile
  region  = var.region
}
