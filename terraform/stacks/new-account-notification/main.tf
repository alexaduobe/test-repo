resource "aws_cloudwatch_event_rule" "sns" {
  name        = "account-creation-control-tower"
  description = "New Account Creation in Control Tower"

  event_pattern = <<EOF
{
  "source": ["aws.controltower"],
  "detail-type": ["AWS Service Event via CloudTrail"],
  "detail": {
    "eventName": ["CreateManagedAccount"]
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.sns.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.default.arn
}

resource "aws_sns_topic" "default" {
  name = local.sns_name
}

resource "aws_sns_topic_subscription" "email_target" {
  topic_arn              = aws_sns_topic.default.arn
  protocol               = "email"
  endpoint               = "daughertylabsupport@daugherty.com"
  endpoint_auto_confirms = true
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.default.arn
  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Id":"__default_policy_ID",
  "Statement":[{
    "Sid":"__default_statement_ID",
    "Effect":"Allow",
    "Principal":{
      "AWS":"*"
    },
    "Action":["SNS:Publish","SNS:RemovePermission","SNS:SetTopicAttributes","SNS:DeleteTopic","SNS:ListSubscriptionsByTopic","SNS:GetTopicAttributes","SNS:Receive","SNS:AddPermission","SNS:Subscribe"],
    "Resource":"${aws_sns_topic.default.arn}",
    "Condition":{
      "StringEquals":{
        "AWS:SourceOwner":"${var.aws_account_id}"
      }
    }
  }]
}
POLICY

}

data "aws_iam_policy_document" "lambda_topic_policy" {
  statement {

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }

}

resource "aws_lambda_function" "create-send-sns" {
  environment {
    variables = {
      TOPIC_ARN = aws_sns_topic.default.arn
    }
  }
  filename      = "email.zip"
  function_name = "create-send-sns"
  role          = "aws_iam_role.lambda_role"
  handler       = "index.handler"
  runtime       = "python3.7"

}

resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.sns.name
  target_id = "TriggerLambda"
  arn       = aws_lambda_function.create-send-sns.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.create-send-sns.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.sns.arn
}

resource "aws_iam_role" "lambda_role" {
  name               = local.lambda_name
  assume_role_policy = data.aws_iam_policy_document.lambda_topic_policy.json
}
