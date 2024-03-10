resource "aws_security_group" "aurora_sg" {
  name        = "aurora-database-sg"
  vpc_id      = aws_vpc.database_vpc.id

  # Inbound Rules
  ingress {
    from_port       = 3306  # Adjust for your database engine (MySQL example)
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = [aws_vpc.database_vpc.id] 
  }

  # Outbound Rules (often more permissive)
  egress {
    from_port       = 0  # Allow all outbound
    to_port         = 0
    protocol        = "-1" 
    cidr_blocks     = ["0.0.0.0/0"]  # Allow all destinations
  }

  tags = {
    Name = "Aurora Database Security Group"
  }
}