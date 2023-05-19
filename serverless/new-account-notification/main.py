import os
import boto3


def lambda_handler(event, context):
    sns = boto3.client('sns')
    subject = "AWS New Account"
    topic_arn = os.environ.get('TOPIC_ARN')
    account_name = event["detail"]["serviceEventDetails"]["createManagedAccountStatus"]["account"]["accountName"]
    account_id = event["detail"]["serviceEventDetails"]["createManagedAccountStatus"]["account"]["accountId"]

    message = f'New AWS account was created. Account Name: {account_name}, Account ID: {account_id}'

    response = sns.publish(
        TopicArn = topic_arn,
        Message = message,
        Subject = subject
    )

    return {
        'statusCode': 200,
        'message': 'Success!',
        'accountName': account_name,
        'accountId': account_id,
        'body': response
    }
