terraform {
  required_version = "1.1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.37.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.0"
    }
  }

  backend "s3" {
    region         = "us-east-2"
    bucket         = "dl-aws-mgmt-tfstate-187402594320"
    key            = "accountfactory-for-terraform/terraform.tfstate"
    dynamodb_table = "dl-aws-mgmt-tfstate-187402594320-lock"
    encrypt        = "true"
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

provider "archive" {}

provider "random" {}

provider "local" {}

provider "time" {}
