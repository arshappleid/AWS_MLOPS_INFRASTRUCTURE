
// Automatically zips the python function file
resource "null_resource" "lambda_zip" {
  triggers = {
    filename = "${path.module}/lambda.py"
  }

  provisioner "local-exec" {
    command = "zip ${path.module}/lambda.zip ${path.module}/lambda.py"
  }
}

resource "aws_lambda_function" "trigger_sagemaker_pipeline" {
  filename      = "${path.module}/lambda.zip" // since the file is in the same repo
  function_name = "Trigger-Sagemaker-Pipeline"
 role          = aws_iam_role.lambda_exec_role.arn
  handler       = "alarm.lambda_handler"
  runtime       = "python3.10"
  environment {
    variables = {
      PIPELINE_NAME = aws_sagemaker_pipeline.deployment_pipeline.pipeline_name
	  BRANCH_NAME = var.code_commit_branch_name_for_pipeline_trigger
    }
  }
}


resource "aws_iam_role" "lambda_exec_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "lambda_sagemaker_exec_policy" {
  role   = aws_iam_role.lambda_exec_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "sagemaker:StartPipelineExecution",
      ]
      Effect   = "Allow"
      Resource = "*"
    }]
  })
}
