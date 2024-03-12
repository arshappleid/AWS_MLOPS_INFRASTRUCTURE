resource "aws_sagemaker_pipeline" "deployment_pipeline" {
  pipeline_name         = var.sagemaker_pipeline_name
  pipeline_display_name = var.sagemaker_pipeline_name
  role_arn              = aws_iam_role.sagemaker_pipeline_iam_role.arn

  pipeline_definition = jsonencode({
    Version = "2020-12-01"
    Steps = [{
      Name = "Test"
      Type = "Fail"
      Arguments = {
        ErrorMessage = "test"
      }
    }]
  })
}