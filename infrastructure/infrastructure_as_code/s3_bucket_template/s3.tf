resource "aws_s3_bucket" "s3_data_source" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "MyS3Bucket"
    Environment = var.environment
  }
  
  dynamic "lifecycle_rule" {
    for_each = var.s3_bucket_data_transition_days > 0 ? [1] : []
    content {
      id      = "log"
      enabled = true

      transition {
        days          = var.s3_bucket_data_transition_days
        storage_class = var.s3_bucket_data_transition_zone
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.s3_bucket_data_expiration_days > 0 ? [1] : []
    content {
      id      = "expiration_policy"
      enabled = true

      expiration {
        days = var.s3_bucket_data_expiration_days
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_policy_1" {
  bucket = aws_s3_bucket.s3_data_source.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket" "log_bucket" {
  bucket = "log-bucket-for-${var.s3_bucket_name}"

}

resource "aws_s3_bucket_public_access_block" "public_access_policy_2" {
  bucket = aws_s3_bucket.log_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_logging" "example" {
  bucket = aws_s3_bucket.s3_data_source.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}


