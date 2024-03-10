module "main_datasource" {
  source                         = "./data_sources"
  environment                    = "DEV"
  s3_bucket_name                 = "my_s3_Bucket"
  s3_bucket_data_transition_days = 45
  s3_bucket_data_transition_zone = "STANDARD_IA"
  s3_bucket_data_expiration_days = 90

  vpc_cidr = "10.1.0.0/16"
  database_az_list = ["us-east-1a" , "us-east-1b"]
  database_name            = "My New Database"
  database_master_username = "master"
  database_master_password = "password"
}
module "prod_model_train" {
  source                       = "./model_train_infrastructure"
  vpc_cidr_block  = "10.2.0.0/16"
  project_name                 = "Project 1"
  code_commit_repo_name        = "Project 1 Repo"
  code_commit_repo_description = "Project 1 , that trains a prediction model on current demand data"
  s3_bucket_list_arn           = [module.main_datasource.s3_bucket_arn]
}