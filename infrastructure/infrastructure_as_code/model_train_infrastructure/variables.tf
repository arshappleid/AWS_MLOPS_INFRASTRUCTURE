variable "code_commit_repo_name"{
	type = string
	description = "Code Commit Repo Name to Store the project"
}

variable "code_commit_repo_description"{
	type = string
	description = "Code Commit Repo Description for the project"
}

variable "vpc_cidr_block"{
	type = string
	default = "CIDR block to deploy the Sagemaker Studio in"
}
variable "project_name"{
	type = string
	description = "A project name ex Demand_Predicting_Model"
}
variable "az1"{
	type = string
	description = "AZ-1 in which to deploy the notebook units in"
	default = "us-east-1a"
}

variable "az2"{
	type = string
	description = "AZ-2 in which to deploy the notebook units in"
	default = "us-east-1b"
}

variable "sagemaker_domain_name"{
	type = string
	description = "Domain Name for the project"
	default = "project-x"
}
variable "s3_bucket_list_arn" {
  type = list(string)
  description = "All the s3 buckets, you want sagemaker domain access to"
}
