resource "aws_cloudwatch_event_rule" "cttagger" {
  count = var.enabled ? 1 : 0

  name          = local.event_rule_name
  description   = "Capture ControlTower events for tagging"
  event_pattern = <<EOF
{
  "source": ["aws.controltower"],
  "detail-type": ["AWS Service Event via CloudTrail"],
  "detail": {
    "eventName": [
      "SetupLandingZone",
      "UpdateLandingZone",
      "RegisterOrganizationalUnit",
      "DeregisterOrganizationalUnit",
      "CreateManagedAccount",
      "UpdateManagedAccount"
    ]
  }
}
EOF

  tags = merge(var.tags, {
    Name = local.event_rule_name
  })
}

resource "aws_cloudwatch_event_target" "cttagger" {
  count = var.enabled ? 1 : 0

  rule = aws_cloudwatch_event_rule.cttagger[0].name
  arn  = module.cttagger_lambda.lambda_function_arn
}
