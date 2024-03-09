module "s3_bucket_for_datastore" {
  source = "./../s3_bucket_template/"
  environment =  var.environment
  s3_bucket_name = var.s3_bucket_name
  s3_bucket_data_transition_days = var.s3_bucket_data_transition_days
  s3_bucket_data_transition_zone = var.s3_bucket_data_transition_zone
  s3_bucket_data_expiration_days = var.s3_bucket_data_expiration_days
}