resource "aws_sagemaker_domain" "example" {
  auth_mode  = "IAM"
  domain_name = var.sagemaker_domain_name
  vpc_id = aws_vpc.sagemaker_vpc.id
  subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  
  default_user_settings {
    execution_role = aws_iam_role.sagemaker_cross_account_role.arn
    security_groups = [aws_security_group.sagemaker_domain_sg.id]
  }
}