resource "aws_security_group" "sagemaker_domain_sg" {
  vpc_id = aws_vpc.sagemaker_vpc.id
  description = "Allow Connect from Sagemaker VPC"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "-1"
    cidr_blocks = ["${aws_vpc.sagemaker_vpc.id}"]
	description = "Allow HTTPS Inbound connection from other resources inside the VPC"
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "-1"
    cidr_blocks = ["${aws_vpc.sagemaker_vpc.id}"]
	description = "Allow HTTPS Outbound connection to other resources inside the VPC"
  }
}