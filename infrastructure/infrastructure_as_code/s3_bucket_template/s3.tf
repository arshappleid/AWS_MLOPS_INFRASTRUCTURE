resource "aws_s3_bucket" "s3_data_source" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "MyS3Bucket"
    Environment = var.environment
  }
  
}

resource "aws_s3_bucket_lifecycle_configuration" "data_transition_rule"{
   count = var.s3_bucket_data_transition_days > 0 ? 1 : 0
   bucket = aws_s3_bucket.s3_data_source.id

   rule {
      id      = "log"
      status = "Enabled"
      transition {
        days          = var.s3_bucket_data_transition_days
        storage_class = var.s3_bucket_data_transition_zone
      }
   }
}

resource "aws_s3_bucket_lifecycle_configuration" "data_expiration_rule"{
  count = var.s3_bucket_data_expiration_days > 0 ? 1 : 0
  bucket = aws_s3_bucket.s3_data_source.id
  
    rule {
      id      = "expiration_policy"
      status = "Enabled"
      expiration {
        days = var.s3_bucket_data_expiration_days
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


