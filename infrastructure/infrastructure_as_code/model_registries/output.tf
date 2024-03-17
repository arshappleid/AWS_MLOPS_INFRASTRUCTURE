output "DOCKER_ECR_IMAGE_REGISTRY_URI" {
	value = aws_ecr_repository.model_registry.repository_url
	description = "Registry URL to look up the models"
}