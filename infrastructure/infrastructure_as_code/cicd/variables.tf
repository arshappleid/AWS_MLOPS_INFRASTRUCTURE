variable "project_name" {
  type        = string
  description = "Project Name"
}

variable "environment" {
  type    = string
  default = "DEV"
}

variable "build_timeout_mins" {
  type        = number
  default     = 5
  description = "Timeout of a build in minutes"
}

variable "environment_variables" {
  type = list(object({
    name  = string
    value = string
    type  = optional(string) # `type` is optional
  }))
  description = "List of Environment variables , to be used for the build environment. type = PARAMETER_STORE , indicates that the value comes from a parameter store."
  default = [
    {
      name  = "SOME_KEY1"
      value = "SOME_VALUE1"
    },
    {
      name  = "SOME_KEY2"
      value = "SOME_VALUE2"
      type  = "PARAMETER_STORE"
      }, {
      name  = "SOME_KEY1"
      value = "SOME_VALUE1"
      type  = "SECRETS_MANAGER"
    }
  ]

  validation {
    condition = alltrue([
      for variable in var.environment_variables : contains(["SECRETS_MANAGER", "PARAMETER_STORE", null], variable.type)
    ])
    error_message = "Incorrect Format of Environment Variables , Check documentation at : https://docs.aws.amazon.com/codepipeline/latest/userguide/action-reference-CodeBuild.html"
  }
}

variable "CODE_SRC_TYPE" {
  type        = string
  description = "Type of Repository : CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE, BITBUCKET, S3"
  validation {
    condition     = length(var.CODE_SRC_TYPE) > 0
    error_message = "The CODE_SRC_TYPE must not be empty."
  }
}

variable "CODE_SRC_ARN" {
  type        = string
  description = "ARN For the Code Commit Repo"
}

variable "CODE_SRC_URL" {
  type        = string
  description = "URL for the git repo"
  validation {
    condition     = length(var.CODE_SRC_URL) > 0
    error_message = "The CODE_SRC_URL must not be empty."
  }
}

variable "CODE_PIPELINE_TRIGGER_REPO_BRANCH" {
  type        = string
  default     = "main"
  description = "At which branch to trigger the Code Pipeline"
}

variable "CODEBUILD_BUILD_STAGE_UNIT" {
  type        = string
  description = "Compute type for the build Unit Examples : SMALL, MEDIUM , LARGE , 2XLARGE "
  default     = "MEDIUM"
  validation {
    condition     = contains(["SMALL", "MEDIUM", "LARGE", "2XLARGE"], variable.type)
    error_message = "Incorrect Unit Type , for CODEBUILD-BUILD-UNIT"
  }
}

variable "CODEBUILD_TEST_STAGE_UNIT" {
  type        = string
  description = "Compute type for the build Unit Examples : SMALL, MEDIUM , LARGE , 2XLARGE "
  default     = "MEDIUM"
  validation {
    condition     = contains(["SMALL", "MEDIUM", "LARGE", "2XLARGE"], variable.type)
    error_message = "Incorrect Unit Type , for CODEBUILD-BUILD-UNIT"
  }
}

variable "DOCKER_ECR_IMAGE_REGISTRY_URI" {
  type        = string
  description = "URI of your Docker image hosted in ECR. ECR image URIs typically follow the format ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com/REPOSITORY_NAME:TAG."

  validation {
    condition     = length(var.example_variable) > 0
    error_message = "The DOCKER_ECR_IMAGE_REGISTRY_URI must not be empty."
  }
}

variable "code_commit_repo_arn" {
  description = "ARN for the code commit repo , to give code builder access to."
}
