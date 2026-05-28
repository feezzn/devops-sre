terraform {
  required_version = "~>1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.46.0"
    }
  }
  backend "s3" {
    bucket       = "felps-tf-state"
    key          = "felps-tf-state/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner       = "devops-sre"
      Environment = "dev"
      managed_by  = "terraform"
    }
  }
}