resource "aws_ecr_repository" "foo" {
  name                 = "${var.project_name}-ECR-Registry"
  image_tag_mutability = "IMMUTABLE"
  force_delete = false

  dynamic "encryption_configuration"{
	for_each = var.ecr_encryption ? [1]:[]
	content {
		encryption_type = "AES256"
	}
  }
  image_scanning_configuration {
    scan_on_push = var.ecr_image_scanning
  }
}