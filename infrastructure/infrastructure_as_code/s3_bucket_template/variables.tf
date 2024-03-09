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


