module "main_datasource" {
  source = "./data_sources"
  environment = "PROD"
  s3_bucket_name = "my_s3_Bucket"
  s3_bucket_data_transition_days = 45
  s3_bucket_data_transition_zone = "STANDARD_IA"
  s3_bucket_data_expiration_days = 90
}
module "prod_model_train" {
  source = "./model_train_infrastructure"
}