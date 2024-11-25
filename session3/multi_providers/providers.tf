
terraform {
  backend "s3" {
    bucket         = "ankur-terraform-state"
    key            = "terraform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-1"
  alias = "us-west"
}