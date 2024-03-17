output "bucket_arn" {
	value = aws_s3_bucket.s3_data_source.arn
}

output "region" {
	value = aws_s3_bucket.s3_data_source.region
	description = "Region in Which the S3 bucket is hosted"
}