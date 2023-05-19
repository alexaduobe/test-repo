import unittest
import os
import json
import boto3
from moto import mock_sns
from main import lambda_handler

os.environ['AWS_ACCESS_KEY_ID'] = 'testing'
os.environ['AWS_SECRET_ACCESS_KEY'] = 'testing'
os.environ['AWS_SECURITY_TOKEN'] = 'testing'
os.environ['AWS_SESSION_TOKEN'] = 'testing'
os.environ['AWS_DEFAULT_REGION'] = 'us-east-1'


class TestMain(unittest.TestCase):
    with open('event.json') as event_file:
        event_json = event_file.read()

    event = json.loads(event_json)
    mock_sns = mock_sns()

    def setUp(self):
        self.mock_sns.start()
        sns = boto3.client("sns", region_name="us-east-1")
        mock_topic = sns.create_topic(Name="mock-topic")
        topic_arn = mock_topic.get("TopicArn")
        os.environ['TOPIC_ARN'] = topic_arn

    def tearDown(self):
        self.mock_sns.stop()

    def test(self):
        response = lambda_handler(self.event, None)

        status_code = response['statusCode']
        expected_status_code = 200
        self.assertEqual(status_code, expected_status_code)

        message = response['message']
        expected_message = 'Success!'
        self.assertEqual(message, expected_message)

        account_name = response['accountName']
        expected_account_name = 'NewAccount'
        self.assertEqual(account_name, expected_account_name)

        account_id = response['accountId']
        expected_account_id = 'NewAccountID'
        self.assertEqual(account_id, expected_account_id)

        http_status_code = response['body']['ResponseMetadata']['HTTPStatusCode']
        expected_http_status_code = 200
        self.assertEqual(http_status_code, expected_http_status_code)
