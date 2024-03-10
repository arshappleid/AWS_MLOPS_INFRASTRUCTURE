resource "aws_cloudwatch_event_rule" "codecommit_rule" {
  name        = "CodeCommit${var.code_commit_branch_name_for_pipeline_trigger}BranchCommitRule"
  description = "Triggers on commits to the main branch of the specified CodeCommit repository."

  event_pattern = jsonencode({
    source = ["aws.codecommit"]
    detail-type = ["CodeCommit Repository State Change"]
    resources = ["arn:aws:codecommit:region:account-id:${var.code_commit_repo_name}"]
    detail = {
      event = ["referenceCreated", "referenceUpdated"]
      referenceType = ["branch"]
      referenceName = [var.code_commit_branch_name_for_pipeline_trigger]
    }
  })
}
// Configure the Lambda Function as the Target for the EventBridge Rule
resource "aws_cloudwatch_event_target" "invoke_lambda" {
  rule      = aws_cloudwatch_event_rule.codecommit_rule.name
  target_id = "TriggerSageMakerPipelineTarget"
  arn       = aws_lambda_function.trigger_sagemaker_pipeline.arn
}
// Grant EventBridge Permission to Invoke the Lambda Functiont 
resource "aws_lambda_permission" "allow_eventbridge_to_invoke_lambda" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.trigger_sagemaker_pipeline.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.codecommit_rule.arn
}
