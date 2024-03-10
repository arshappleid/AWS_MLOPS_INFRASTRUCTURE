// AZ - 1 Subnet
resource "aws_subnet" "az1_private_subnet" {
  vpc_id            = aws_vpc.database_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.database_vpc.cidr_block, 8, 1) // 10.1.1.0/24
  availability_zone = var.database_az_list[0]
  tags = {
    Name = "${var.database_name}-AZ-1_Subnet"
  }
}

// AZ-  2 Subnet
resource "aws_subnet" "az2_private_subnet" {
  vpc_id            = aws_vpc.database_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.database_vpc.cidr_block, 8, 2) // 10.1.2.0/24
  availability_zone = var.database_az_list[1]
  tags = {
    Name = "${var.database_name}-AZ-2_Subnet"
  }
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = [
    aws_subnet.az1_private_subnet.id, 
    aws_subnet.az2_private_subnet.id
  ]
}