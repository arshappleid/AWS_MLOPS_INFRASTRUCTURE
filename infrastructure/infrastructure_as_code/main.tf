locals {
  project_name = "PROJECT-1"
}
module "main_datasource" {
  source                         = "./data_sources"
  environment                    = "DEV"
  s3_bucket_name                 = "my-s3-Bucket"
  s3_bucket_data_transition_days = 45
  s3_bucket_data_transition_zone = "STANDARD_IA"
  s3_bucket_data_expiration_days = 90

  vpc_cidr                 = "10.1.0.0/16"
  database_az_list         = ["us-east-1a", "us-east-1b"]
  database_name            = "My New Database"
  database_master_username = "master"
  database_master_password = "password"
}
module "prod_model_train" {
  source                       = "./development_environment"
  vpc_cidr_block               = "10.2.0.0/16"
  project_name                 =  local.project_name
  code_commit_repo_name        = "${local.project_name}-REPO"
  code_commit_repo_description = "Project 1 , that trains a prediction model on current demand data"
  s3_bucket_list_arn           = [module.main_datasource.s3_bucket_arn]
}

module "operations_account" {
  source                                       = "./operations_environment"
  sagemaker_pipeline_name                      = "My-New-pipeline"
  code_commit_repo_name                        = module.prod_model_train.code_commit_repo_name
  code_commit_branch_name_for_pipeline_trigger = "main"
}

module "model_registry"{
  source = "./model_registries"
  project_name = local.project_name
}

module "cicd"{
  source = "./cicd"
  project_name = local.project_name
  code_commit_repo_arn = module.prod_model_train.code_commit_repo_arn
  CODE_SRC_TYPE = "CODECOMMIT"
  CODE_SRC_URL = module.prod_model_train.code_commit_repo_clone_ulr
  DOCKER_ECR_IMAGE_REGISTRY_URI = module.model_registry.DOCKER_ECR_IMAGE_REGISTRY_URI
}