module "cttagger_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "2.34.1"

  create        = var.enabled
  function_name = local.function_name
  description   = "DO NOT DELETE - Tag new resources upon creation"
  handler       = "tagger.handler"
  runtime       = "python3.9"
  publish       = true
  timeout       = 300

  create_role      = true
  role_name        = "${local.function_name}-execution"
  role_description = "Lambda role for organization setup function"
  role_tags = {
    Name = "role/${local.function_name}-execution"
  }
  attach_cloudwatch_logs_policy = true
  attach_policy_json            = true
  policy_json                   = data.aws_iam_policy_document.manage_org.json

  create_package = var.enabled
  source_path    = "${path.module}/../../../../serverless/controltower-tagger"

  store_on_s3               = true
  s3_bucket                 = var.artifact_s3_bucket
  s3_server_side_encryption = "AES256"
  s3_prefix                 = "lambda-builds/"
  s3_object_tags_only       = true
  s3_object_tags            = local.artifact_tags

  artifacts_dir = "${path.root}/.terraform/lambda-builds/"

  allowed_triggers = {
    ScanAmiRule = {
      principal  = "events.amazonaws.com"
      source_arn = var.enabled ? aws_cloudwatch_event_rule.cttagger[0].arn : ""
    }
  }

  use_existing_cloudwatch_log_group = false
  cloudwatch_logs_retention_in_days = 7
  cloudwatch_logs_kms_key_id        = var.logs_kms_key
  cloudwatch_logs_tags = {
    Name = "/aws/lambda/${local.function_name}"
  }

  tags = var.tags
}
