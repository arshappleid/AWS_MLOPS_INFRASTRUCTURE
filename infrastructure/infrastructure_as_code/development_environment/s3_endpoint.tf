// An S3 Ednpoint to the s3 bucket in the Data Sources VPC
resource "aws_route_table" "s3_route_table" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.sagemaker_vpc.id
  service_name = "com.amazonaws.${module.s3_bucket_model_store.region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [aws_route_table.s3_route_table.id] // AWS Adds the route automatically

  tags = {
    Environment = var.environment
  }
}



