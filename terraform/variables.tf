# variables.tf
# Define input variables for the Terraform configuration

# AWS region variable
variable "aws_region" {
    description = "The AWS region to deploy resources in"
    type        = string
    default     = "us-east-1"
}

# S3 bucket name variable
variable "bucket_name" {
    description = "The name of the S3 bucket to create"
    type        = string
    default     = "clayton-secure-storage-lab-2026"
}

# Enable versioning for the S3 bucket
variable "enable_versioning" {
    description = "Enable versioning for the S3 bucket"
    type        = bool
    default     = true
}

# Environment tag
variable "environment" {
    description = "The environment for the resources"
    type        = string
    default     = "Development"
}
