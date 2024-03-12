import os
import boto3
import json

def lambda_handler(event, context):
    # Initialize the SageMaker client
    sagemaker_client = boto3.client('sagemaker')
    pipeline_name = os.environ.get('PIPELINE_NAME')
    branch_name = os.environ.get('BRANCH_NAME')
    # Start the pipeline execution
    response = sagemaker_client.start_pipeline_execution(
        PipelineName=pipeline_name,
        PipelineExecutionDisplayName='TriggeredByCodeCommit',
        PipelineParameters=[
            # Add any pipeline parameters here, if necessary
            # {
            #     'Name': 'ParameterName',
            #     'Value': 'ParameterValue'
            # },
        ],
        PipelineExecutionDescription= f'This execution was triggered by a commit to the main {branch_name} in CodeCommit.'
    )
    
    # Log and return the response
    print("Pipeline execution started:", json.dumps(response, indent=4))
    return {
        'statusCode': 200,
        'body': json.dumps('SageMaker Pipeline execution started successfully.')
    }
