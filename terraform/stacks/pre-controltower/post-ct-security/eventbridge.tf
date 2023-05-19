resource "aws_cloudwatch_event_rule" "landing_zone_created" {
  count = var.enabled ? 1 : 0

  name          = local.event_rule_name
  description   = "ControlTower SetupLandingZone Event succeeded..."
  event_pattern = <<EOF
{
  "source": ["aws.controltower"],
  "detail-type": ["AWS Service Event via CloudTrail"],
  "detail": {
    "eventName": ["SetupLandingZone"]
  }
}
EOF

  tags = merge(var.tags, {
    Name = local.event_rule_name
  })
}

resource "aws_cloudwatch_event_target" "postct_security_lambda" {
  count = var.enabled ? 1 : 0

  rule = aws_cloudwatch_event_rule.landing_zone_created[0].name
  arn  = module.postct_security_lambda.lambda_function_arn
}
