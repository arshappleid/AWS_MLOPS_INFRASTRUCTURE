output "code_commit_repo_clone_ulr" {
	value = aws_codecommit_repository.project_repo.clone_url_http
	description = "clone url for the project repo"
}

output "code_commit_repo_name"{
	value = aws_codecommit_repository.project_repo.repository_name
}