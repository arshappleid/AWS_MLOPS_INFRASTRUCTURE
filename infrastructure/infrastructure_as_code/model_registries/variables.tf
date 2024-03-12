variable "project_name"{
	type = string
	description = "Project Name assigned"
}

variable "ecr_image_scanning"{
	type = bool
	default = true
	description = "defines image scanning configuration for the ecr repository"
}

variable "ecr_encryption"{
	type = bool
	default = false
	description = "Encrypt the images inside the ecr repository using AES256 Algorithm"
}