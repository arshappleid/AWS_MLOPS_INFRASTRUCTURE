resource "aws_sagemaker_notebook_instance" "notebook_1" {
  name          = "my-notebook-instance"
  role_arn      = aws_iam_role.notebook_iam.arn
  instance_type = "ml.t2.medium"

  tags = {
    Name = "Notebook_1"
  }
}