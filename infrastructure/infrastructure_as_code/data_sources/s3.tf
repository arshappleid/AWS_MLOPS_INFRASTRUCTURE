resource "aws_s3_bucket" "s3_data_source" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "MyS3Bucket"
    Environment = var.environment
  }

  versioning {
    enabled = true
  }

  public_access_block {
    block_public_acls       = true
    ignore_public_acls      = true
    block_public_policy     = true
    restrict_public_buckets = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
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

resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-log-bucket-name"
  public_access_block {
    block_public_acls       = true
    ignore_public_acls      = true
    block_public_policy     = true
    restrict_public_buckets = true
  }
}

