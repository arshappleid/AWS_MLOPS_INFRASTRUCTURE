// Check all possible steos at : https://docs.aws.amazon.com/codepipeline/latest/userguide/reference-pipeline-structure.html#action-requirements
resource "aws_codepipeline" "codepipeline" {
  name     = "tf-test-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
    // Provision KMS Key to 
  }

  // Where are we getting the code from ?
  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]


      // Check Config at : https://docs.aws.amazon.com/codepipeline/latest/userguide/action-reference-CodeCommit.html#action-reference-CodeCommit-config
      configuration = {
        // Might Need Repository Name Instead
        ProjectName   = aws_codebuild_project.build_stage.name
        ConnectionArn = var.CODE_SRC_ARN
        BranchName    = var.CODE_PIPELINE_TRIGGER_REPO_BRANCH
      }
    }
  }

  stage {
    name = "Test"
    action {
      name     = "Test"
      category = "Test"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"
      configuration = {
        ProjectName          = aws_codebuild_project.test_stage.name
        EnvironmentVariables = var.environment_variables
      }
    }
  }

  // Where Are We building the code at ?
  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      // Check Config at : https://docs.aws.amazon.com/codepipeline/latest/userguide/action-reference-CodeBuild.html#action-reference-CodeBuild-config
      configuration = {
        ProjectName          = "test"
        EnvironmentVariables = var.environment_variables
      }
    }
  }

  // Where are we deploying the code onto ?
  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ActionMode     = "REPLACE_ON_FAILURE"
        Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
        OutputFileName = "CreateStackOutput.json"
        StackName      = "MyStack"
        TemplatePath   = "build_output::sam-templated.yaml"
      }
    }
  }

}
