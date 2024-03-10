resource "aws_vpc" "sagemaker_vpc"{
	cidr_block = var.vpc_cidr_block
	enable_dns_support = true
	enable_dns_hostnames = true
	tags = {
		Name = var.project_name
	}
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.sagemaker_vpc.id
  cidr_block = cidrsubnet(aws_vpc.sagemaker_vpc.cidr_block, 8, 1) // 10.2.1.0/24
  availability_zone = var.az1
}

resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.sagemaker_vpc.id
  cidr_block = cidrsubnet(aws_vpc.sagemaker_vpc.cidr_block, 8, 2) // 10.2.2.0/24
  availability_zone = var.az2
}