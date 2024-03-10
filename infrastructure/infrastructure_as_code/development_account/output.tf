output "code_commit_repo_clone_ulr" {
	value = aws_codecommit_repository.project_repo.clone_url_http
	description = "clone url for the project repo"
}