resource "aws_iam_role" "sagemaker_cross_account_role" {
  name = "SageMakerCrossAccountRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_iam_policy" "sagemaker_cross_account_access" {
  name        = "SageMakerCrossAccountAccessPolicy"
  description = "Policy for SageMaker Domain to access resources in different accounts"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = concat(
		 [for arn in var.s3_bucket_list_arn : "${arn}"],
          [for arn in var.s3_bucket_list_arn : "${arn}/*"] 
        )
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sagemaker_cross_account_attachment" {
  role       = aws_iam_role.sagemaker_cross_account_role.name
  policy_arn = aws_iam_policy.sagemaker_cross_account_access.arn
}
