// Create the Role
resource "aws_iam_role" "sagemaker_pipeline_iam_role" {
  name = "SageMakerPipelineRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
      },
    ]
  })
}
// Attach Policy Controlling all the actions to the role
resource "aws_iam_policy" "sagemaker_pipeline_policy" {
  name = "SageMakerPipelinePolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "iam:PassRole",
          "sagemaker:*",
          // Add any other permissions needed
        ]
        Effect = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sagemaker_pipeline_policy_attachment" {
  role       = aws_iam_role.sagemaker_pipeline_iam_role.name
  policy_arn = aws_iam_policy.sagemaker_pipeline_policy.arn
}
