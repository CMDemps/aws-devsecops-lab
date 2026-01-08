# main.tf
# Main infrastructure definitions

#############################################
# S3 Bucket Resource
#############################################
resource "aws_s3_bucket" "secure_storage" {
  # Resource type: S3 Bucket
  # Local name: secure_storage

  bucket = var.bucket_name
  # Force destroy allowed for lab learning purposes
  force_destroy = true

  tags = {
    Name        = var.bucket_name
    Description = "Secure storage bucket for DevSecOps Lab"
  }
}

#############################################
# Security Layer 1: Encryption at Rest
#############################################
resource "aws_s3_bucket_server_side_encryption_configuration" "secure_storage" {
  # Resource type: S3 Bucket Server-Side Encryption Configuration
  # Local name: secure_storage

  bucket = aws_s3_bucket.secure_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#############################################
# Security Layer 2: Versioning
#############################################
resource "aws_s3_bucket_versioning" "secure_storage" {
  # Resource type: S3 Bucket Versioning
  # Local name: secure_storage

  bucket = aws_s3_bucket.secure_storage.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Disabled"
  }
}

#############################################
# Security Layer 3: Block Public Access
#############################################
resource "aws_s3_bucket_public_access_block" "secure_storage" {
  # Resource type: S3 Bucket Public Access Block
  # Local name: secure_storage

  bucket = aws_s3_bucket.secure_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#############################################
# Security Layer 4: Access Logging
#############################################
resource "aws_s3_bucket" "logs" {
  # Resource type: S3 Bucket
  # Local name: logs

  bucket = "${var.bucket_name}-logs"
  # Force destroy allowed for lab learning purposes
  force_destroy = true

  tags = {
    Name        = "${var.bucket_name}-logs"
    Description = "Access logs bucket for DevSecOps Lab"
  }
}

resource "aws_s3_bucket_logging" "secure_storage" {
  # Resource type: S3 Bucket Logging
  # Local name: secure_storage

  bucket = aws_s3_bucket.secure_storage.id

  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "access-logs/"
}

#############################################
# Security Layer 5: Bucket Policy - TLS Enforcement
#############################################
resource "aws_s3_bucket_policy" "secure_storage" {
  # Resource type: S3 Bucket Policy
  # Local name: secure_storage

  bucket = aws_s3_bucket.secure_storage.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "EnforceTLS"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.secure_storage.arn,
          "${aws_s3_bucket.secure_storage.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

#############################################
# Security Layer 6: Lifecycle Policy - Transition to Glacier
#############################################
resource "aws_s3_bucket_lifecycle_configuration" "secure_storage" {
  # Resource type: S3 Bucket Lifecycle Configuration
  # Local name: secure_storage

  bucket = aws_s3_bucket.secure_storage.id

  rule {
    id     = "ExpireOldVersions"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }

  rule {
    id     = "TransitionToGlacier"
    status = "Enabled"

    filter {}

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }
}
