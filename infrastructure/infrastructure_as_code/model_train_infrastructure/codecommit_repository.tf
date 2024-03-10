resource "aws_codecommit_repository" "project_repo" {
  repository_name = var.code_commit_repo_name
  description     = var.code_commit_repo_description
}
