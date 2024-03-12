resource "aws_sagemaker_model_package_group" "example" {
	model_package_group_name = "${var.project_name}_registry"
}