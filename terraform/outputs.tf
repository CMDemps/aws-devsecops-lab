# outputs.tf
# Values to display after infrastructure is created

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.secure_storage.id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.secure_storage.arn
}

output "bucket_region" {
  description = "Region where bucket is created"
  value       = aws_s3_bucket.secure_storage.region
}

output "logging_bucket_name" {
  description = "Name of the access logs bucket"
  value       = aws_s3_bucket.logs.id
}

output "encryption_algorithm" {
  description = "Encryption algorithm used"
  value       = "AES256"
}

output "versioning_enabled" {
  description = "Whether versioning is enabled"
  value       = var.enable_versioning
}
