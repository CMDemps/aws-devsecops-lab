# versions.tf
# Specify the required Terraform version and provider versions

terraform {
  # Require Terraform version 1.0 or higher
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS provider
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "AWS-DevSecOps-Lab"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Clayton"
      Purpose     = "Security-Portfolio"
    }
  }
}
