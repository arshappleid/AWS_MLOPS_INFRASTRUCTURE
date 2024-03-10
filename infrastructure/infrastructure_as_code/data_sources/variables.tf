variable "environment" {
  type    = string
  default = "DEV"
}
variable "s3_bucket_name" {
  type    = string
  default = ""
}

variable "s3_bucket_data_expiration_days" {
  type        = number
  description = "Expire all the data in these many days"
  default     = 0
}

variable "s3_bucket_data_transition_days" {
  type        = number
  description = "Transition Data into STNDARD IA , after these many days"
  default     = 0
}

variable "s3_bucket_data_transition_zone" {
  type        = string
  description = "Transition Data into STNDARD IA , after these many days"
  default     = "STANDARD_IA"
}
variable vpc_cidr{
  type = string
  description = "VPC CIDR block for the database"
}

variable database_az_list{
  type = list(string)
  description = "List of AZs , you want the database to be deployed in"
  default = ["us-east-1a","us-east-1b"]

   validation {
    condition     = length(var.database_az_list) == 2
    error_message = "The list must contain exactly two availability zones."
  }
}
variable "database_name"{
  type = string
  description = "Database Name for the database to store data"
}

variable "database_master_username"{
  type = string
  description = "Login Master Account username for the database"
}

variable "database_master_password"{
  type = string
  default = "Database Login Master account password , Must be 8 Characters"
}
