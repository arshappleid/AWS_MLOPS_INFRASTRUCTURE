output "s3_bucket_arn" {
	value = module.s3_bucket_for_datastore.bucket_arn
	description = "ARN of the s3 buckets used as a datasource"
}