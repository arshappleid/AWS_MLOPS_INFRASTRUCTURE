resource "aws_s3_bucket" "code_build_cache_s3" {
  bucket = "${var.project_name}-codebuild-cache"
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.code_build_cache_s3.id
  acl    = "private"
}
