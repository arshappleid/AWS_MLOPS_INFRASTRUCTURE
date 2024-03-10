variable "environment" {
  description = "Environment Used"
  default = "DEV"
}
variable "sagemaker_pipeline_name"{
	type = string
	description = "Name for Sagemaker pipeline Name"
}

variable "code_commit_repo_name" {
  type = string
  description = "Code Commit repo name , for the event bridge trigger to trigger Sagemaker Pipeline"
}
variable "code_commit_branch_name_for_pipeline_trigger" {
  type = string
  description = "Trigger the Eventbridge rule to trigger the sagemaker pipeline on this branch"
}