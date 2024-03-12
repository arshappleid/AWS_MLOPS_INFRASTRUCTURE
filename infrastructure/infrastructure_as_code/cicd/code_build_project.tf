// modified from : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project

resource "aws_s3_bucket" "code_build_cache_s3" {
  bucket = "${var.project_name}-codebuild-cache"
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.code_build_cache_s3.id
  acl    = "private"
}

resource "aws_codebuild_project" "example" {
  name                 = "${var.project_name}-codebuild-project"
  build_timeout        = 5
  service_role         = aws_iam_role.code_build_initiator.arn // Role that initiates the build
  resource_access_role = aws_iam_role.code_build_initiator.arn // Role that grants access CloudWatch Logs, S3 bucket
  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.code_build_cache_s3.bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_${var.compute_type}"
    image                       = var.DOCKER_ECR_IMAGE_REGISTRY_URI
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = var.CODE_SRC_TYPE == "CODECOMMIT" ? "CODEBUILD" : "SERVICE_ROLE"

    dynamic "environment_variable" {
      for_each = var.environment_variables

      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
        type  = try(environment_variable.value.type, null) # Use `try` to handle optional 'type'
      }
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.code_build_cache_s3.id}/build-log"
    }
  }

  source {
    type            = var.CODE_SRC_TYPE
    location        = var.CODE_SRC_URL
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }

    report_build_status = var.CODE_SRC_TYPE == "GITHUB" ? true : false
  }
  // Will take the latest verion of the build , since not specified
  tags = {
    Environment = var.environment
  }
}