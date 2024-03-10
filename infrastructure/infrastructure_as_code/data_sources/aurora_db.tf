resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier  = "my-aurora-cluster-${lower(var.environment)}" 
  engine              = "aurora-postgresql"
  engine_version      = "11.15"  # Example; adjust as needed 
  database_name       = "my_database"
  master_username     =  var.database_master_username
  master_password     = var.database_master_password
  backup_retention_period = 5 
  vpc_security_group_ids  = [aws_security_group.aurora_sg.id] 
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name 
  iam_database_authentication_enabled = true // Access to the database through IAM Roles
  # Optional for scaling, replication
  availability_zones      =  var.database_az_list

  # lifecycle {
  #   prevent_destroy = var.environment == "PROD" ? true : false
  # }
}
