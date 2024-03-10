resource "aws_vpc" "database_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "Database VPC"
  }
}