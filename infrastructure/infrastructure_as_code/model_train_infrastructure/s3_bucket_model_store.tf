module "s3_bucket_model_store" {
	source = "../s3_bucket_template"

	s3_bucket_name = "Sagemaker Model Store"
  s3_bucket_data_transition_days = 0
  s3_bucket_data_transition_zone = "STANDARD_IA"
  s3_bucket_data_expiration_days = 0
}