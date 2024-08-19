provider "aws" {
  region = var.AWS-Region
  access_key = var.AWS-Access-Key
  secret_key = var.AWS-Secret-Key
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.47.0"
    }
  }
}
